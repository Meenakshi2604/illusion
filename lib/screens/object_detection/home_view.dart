import 'package:flutter/material.dart';
import 'package:illusion/screens/object_detection/box_widget.dart';
import 'package:illusion/screens/object_detection/camera_view_singleton.dart';
import 'package:illusion/services/recognition.dart';
import 'package:illusion/services/stats.dart';
import 'camera_view.dart';

/// [HomeView] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  /// Results to draw bounding boxes
  List<Recognition>? results;

  /// Realtime stats
  Stats? stats;

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Camera View
          CameraView(resultsCallback, statsCallback),

          // Bounding boxes
          boundingBoxes(results),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.1,
              maxChildSize: 0.5,
              builder: (_, ScrollController scrollController) => Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: borderRadiusBottomSheet),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.keyboard_arrow_up,
                            size: 48, color: Colors.orange),
                        (stats != null)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    StatsRow('Inference time:',
                                        '${stats!.inferenceTime} ms'),
                                    StatsRow('Total prediction time:',
                                        '${stats!.totalElapsedTime} ms'),
                                    StatsRow('Pre-processing time:',
                                        '${stats!.preProcessingTime} ms'),
                                    StatsRow('Frame',
                                        '${CameraViewSingleton.inputImageSize?.width} X ${CameraViewSingleton.inputImageSize?.height}'),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition>? results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map((e) => BoxWidget(
                result: e,
              ))
          .toList(),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    if(mounted) {
      setState(() {
      this.results = results;
    });
    }
  }

  /// Callback to get inference stats from [CameraView]
  void statsCallback(Stats stats) {
    if(mounted) {
      setState(() {
      this.stats = stats;
    });
    }
  }

  static const bottomSheetRadius = Radius.circular(24.0);
  static const borderRadiusBottomSheet = BorderRadius.only(
      topLeft: bottomSheetRadius, topRight: bottomSheetRadius);
}

/// Row for one Stats field
class StatsRow extends StatelessWidget {
  final String left;
  final String right;

  const StatsRow(this.left, this.right, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(left), Text(right)],
      ),
    );
  }
}