import 'dart:developer';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:illusion/main.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({Key? key}) : super(key: key);

  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  bool _muteAI = true;
  void Function(SpeechRecognitionError)? errorListener =
      flutterStt.errorListener;
  final ScrollController _scrollController = ScrollController();
  final List<String> _texts = [
    "Please press the microphone button to start speaking"
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        flutterStt.errorListener = errorListener;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colours.backgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: !_muteAI,
          glowColor: Colors.indigoAccent,
          endRadius: 50.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            child: Icon(
              _muteAI ? CupertinoIcons.mic_off : CupertinoIcons.mic,
              size: 30,
              color: Colors.white54,
            ),
            backgroundColor: _muteAI
                ? Colours.primaryColor.withOpacity(.5)
                : Colours.primaryColor.withOpacity(.35),
            onPressed: () {
              _listen();
            },
          ),
        ),
        body: SafeArea(
          child: Neumorphic(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 120,
              ),
              child: ListView.builder(
                reverse: true,
                controller: _scrollController,
                itemCount: _texts.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  children: [
                    if (index == _texts.length - 1)
                      Center(
                          child: Lottie.asset(
                        "assets/robot.json",
                        height: 200,
                      )),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _texts[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_muteAI) {
      if (mounted) {
        setState(() {
          _muteAI = true;
          _texts.remove("Listening...");
          _texts.add("Please press the microphone button to start speaking");
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate,
          );
        });
      }
      flutterStt.stop();
    } else {
      if (mounted) {
        setState(() {
          if (_texts
              .remove("Please press the microphone button to start speaking")) {
            _texts.clear();
          }
          _texts.add("Listening...");
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate,
          );
        });
      }

      flutterStt.errorListener = (val) {
        log('onError: $val');
        if (val.errorMsg != 'error_busy') {
          _muteAI = true;
          _texts.remove("Listening...");
          flutterStt.stop();
          _listen();
        }
      };

      bool available = await flutterStt.initialize();

      if (available) {
        if (mounted) {
          setState(() {
            _muteAI = false;
          });
        }

        String text = "";

        flutterStt.listen(
            onSoundLevelChange: (sound) {},
            onResult: (val) {
              if (mounted) {
                setState(() {
                  _texts.remove("Listening...");
                  _texts.remove(text);
                  text = val.recognizedWords;
                  _texts.add(text);
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.decelerate,
                  );
                });
              }

              if (val.finalResult) {
                _muteAI = true;
                flutterStt.stop();
                _listen();
              }
            });
      }
    }
  }
}
