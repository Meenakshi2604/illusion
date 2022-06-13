import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:illusion/screens/text_to_speech/tts_page.dart';
//import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt1;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../main.dart';

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({Key? key}) : super(key: key);

  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  bool muteAI = true;
  late stt1.SpeechToText _speech;
  String text = "Please press the microphone button to start speaking";

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
          backgroundColor: muteAI ? Colours.primaryColor: Colors.blueGrey,
          onPressed: () {
            _listen();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Neumorphic(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 650,
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!muteAI) {
      setState(() {
        muteAI = true;
        text = "Please press the microphone button to start speaking";
      });
      _speech.stop();
    } else {
      setState(() {
        text = "Listening...";
      });

      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        setState(() {
          muteAI = false;
        });

        _speech.listen(onResult: (val) {
          setState(() {
            text = val.recognizedWords;
          });
        });
      }
    }
  }
}
