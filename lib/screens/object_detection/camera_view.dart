import 'dart:async';
import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/home/home.dart';
import 'package:illusion/screens/object_detection/camera_view_singleton.dart';
import 'package:illusion/services/classifier.dart';
import 'package:illusion/services/isolate_utils.dart';
import 'package:illusion/services/recognition.dart';
import 'package:lottie/lottie.dart';

/// [CameraView] sends each frame for inference
class CameraView extends StatefulWidget {
  /// Callback to pass results after inference to [HomeView]
  final Function(List<Recognition> recognitions) resultsCallback;

  /// Constructor
  const CameraView(this.resultsCallback, {Key? key}) : super(key: key);
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  /// List of available cameras
  List<CameraDescription>? cameras;

  /// Controller
  CameraController? cameraController;

  /// true when inference is ongoing
  late bool predicting;

  /// Instance of [Classifier]
  late Classifier classifier;

  /// Instance of [IsolateUtils]
  IsolateUtils? isolateUtils;

  List<String?> uniqueRecognitions = [];

  String _text = "Let's see what's in front of you";
  List<String> list = [
    "Detected ",
    "Found ",
    "There's a ",
    "Identified ",
    "Recognized "
  ];

  @override
  void initState() {
    super.initState();
    flutterTts.speak(_text);
    Timer.periodic(const Duration(seconds: 5), (timer) {
      uniqueRecognitions.clear();
    });
    initStateAsync();
  }

  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);

    // Spawn a new isolate
    isolateUtils = IsolateUtils();
    await isolateUtils!.start();

    // Camera initialization
    initializeCamera();

    // Create an instance of classifier to load model and labels
    classifier = Classifier();

    // Initially predicting = false
    predicting = false;
  }

  /// Initializes the camera by setting [cameraController]
  void initializeCamera() async {
    cameras = await availableCameras();

    // cameras[0] for rear-camera
    if (cameras!.isNotEmpty) {
      cameraController = CameraController(cameras![0], ResolutionPreset.high,
          enableAudio: false);
    }

    cameraController!.initialize().then((_) async {
      // Stream of image passed to [onLatestImageAvailable] callback
      await cameraController!.startImageStream(onLatestImageAvailable);

      /// previewSize is size of each image frame captured by controller
      ///
      /// 352x288 on iOS, 240p (320x240) on Android with ResolutionPreset.low
      Size? previewSize = cameraController!.value.previewSize;

      /// previewSize is size of raw input image to the model
      CameraViewSingleton.inputImageSize = previewSize!;

      // the display width of image on screen is
      // same as screenWidth while maintaining the aspectRatio
      setState(() {
        Size screenSize = MediaQuery.of(context).size;
        CameraViewSingleton.screenSize = screenSize;
        CameraViewSingleton.ratio = screenSize.width / screenSize.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Return empty container while the camera is not initialized
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Container();
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AspectRatio(
                    aspectRatio: 1.5 * (size.width / size.height),
                    child: CameraPreview(cameraController!)),
                Center(
                    child: Lottie.asset(
                  "assets/robot.json",
                  height: size.height * 0.15,
                )),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: Text(
                      _text,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _text == "Let's see what's in front of you"
                            ? size.height * 0.020
                            : size.height * 0.022,
                        color: _text == "Let's see what's in front of you"
                            ? Colors.black38
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Callback to receive each frame [CameraImage] perform inference on it
  onLatestImageAvailable(CameraImage cameraImage) async {
    if (classifier.interpreter != null && classifier.labels != null) {
      // If previous inference has not completed then return
      if (predicting) {
        return;
      }

      if (mounted)
        setState(() {
          predicting = true;
        });

      // Data to be passed to inference isolate
      var isolateData = IsolateData(
          cameraImage, classifier.interpreter!.address, classifier.labels!);

      // We could have simply used the compute method as well however
      // it would be as in-efficient as we need to continuously passing data
      // to another isolate.

      /// perform inference in separate isolate
      Map<String, dynamic> inferenceResults = await inference(isolateData);

      for (Recognition recognition in inferenceResults['recognitions']) {
        if (!uniqueRecognitions.contains(recognition.label)) {
          flutterTts.awaitSpeakCompletion(true);
          uniqueRecognitions.add(recognition.label);
          list.shuffle();
          if (mounted) {
            setState(() {
              _text = list[0] + recognition.label!;
            });
          }
          await flutterTts.speak(_text);
        }
      }

      // pass results to HomeView
      widget.resultsCallback(inferenceResults['recognitions']);

      // set predicting to false to allow new frames
      if (mounted) {
        setState(() {
          predicting = false;
        });
      }
    }
  }

  /// Runs inference in another isolate
  Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils!.sendPort!
        .send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        cameraController!.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (!cameraController!.value.isStreamingImages) {
          await cameraController!.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController!.dispose();
    super.dispose();
  }
}
