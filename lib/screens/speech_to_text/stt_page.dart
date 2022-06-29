import 'dart:developer';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:illusion/main.dart';
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
  List<String> _texts = [];
  String _text = "Press the microphone button to start listening";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        child: AvatarGlow(
          animate: !_muteAI,
          glowColor: Colors.indigoAccent,
          endRadius: size.height * 0.05,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            child: Icon(
              _muteAI ? CupertinoIcons.mic_off : CupertinoIcons.mic,
              size: size.height * 0.03,
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 30,
          ),
          child: ListView.builder(
            reverse: true,
            controller: _scrollController,
            itemCount: _texts.isEmpty ? 1 : _texts.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Column(
              children: [
                if (_texts.isEmpty || index == _texts.length - 1)
                  Center(
                      child: Lottie.asset(
                    "assets/robot.json",
                    height: size.height * 0.15,
                  )),
                if (_texts.isEmpty || index == _texts.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: Text(
                      _text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.height * 0.020,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                if (_texts.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _texts[index],
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: size.height * 0.022,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                if (_texts.isEmpty || index == 0)
                  SizedBox(
                    height: size.height * 0.1,
                  ),
              ],
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
          _text = "Press the microphone button to start listening";
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
          _text = "Listening...";
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
