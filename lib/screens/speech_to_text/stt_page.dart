import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../main.dart';

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({Key? key}) : super(key: key);

  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  bool muteAI = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colours.backgroundColor,
        body: SafeArea(
          child:Padding(
          padding: const EdgeInsets.all(15.0),
          child: Neumorphic(
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Neumorphic(
                      child: const SizedBox(
                        height: 650,
                        child: Center(
                          child: Text("Voice will be turned to text"),
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        muteAI
                            ? CupertinoIcons.mic_off
                            : CupertinoIcons.mic,
                        size: 30,
                        color: Colours.tertiaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          muteAI = !muteAI;
                        });
                      },
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
}
