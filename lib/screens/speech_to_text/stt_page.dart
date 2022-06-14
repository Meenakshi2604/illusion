import 'dart:developer';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:illusion/main.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt1;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({Key? key}) : super(key: key);

  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  bool muteAI = true;
  late stt1.SpeechToText _speech;
  List<String> texts = ["Please press the microphone button to start speaking"];

  @override
  void initState() {
    super.initState();
    _speech = stt1.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: !muteAI,
        glowColor: Colors.indigoAccent,
        endRadius: 50.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          child: Icon(
            muteAI ? CupertinoIcons.mic_off : CupertinoIcons.mic,
            size: 30,
            color: Colors.white54,
          ),
          backgroundColor: muteAI ? Colours.primaryColor : Colors.blueGrey,
          onPressed: () {
            _listen();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Neumorphic(
            child: SizedBox(
              child: ListView.builder(
                itemCount: texts.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Neumorphic(
                    style: const NeumorphicStyle(depth: -3.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        texts[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!muteAI) {
      if (mounted) {
        setState(() {
          muteAI = true;
          texts.add("Please press the microphone button to start speaking");
        });
      }
      _speech.stop();
    } else {
      if (mounted) {
        setState(() {
          if (texts
              .remove("Please press the microphone button to start speaking")) {
            texts.clear();
          }
          texts.add("Listening...");
        });
      }

      bool available = await _speech.initialize(
        onStatus: (val) => log('onStatus: $val'),
        onError: (val) {
          log('onError: $val');
          if (val.errorMsg == "error_no_match") {
            muteAI = true;
            texts.remove("Listening...");
            _speech.stop();
            _listen();
          }
        },
      );

      if (available) {
        if (mounted) {
          setState(() {
            muteAI = false;
          });
        }

        String text = "";

        _speech.listen(
            onSoundLevelChange: (sound) {},
            onResult: (val) {
              if (mounted) {
                setState(() {
                  texts.remove("Listening...");
                  texts.remove(text);
                  text = val.recognizedWords;
                  texts.add(text);
                });
              }

              if (val.finalResult) {
                muteAI = true;
                _speech.stop();
                _listen();
              }
            });
      }
    }
  }
}
