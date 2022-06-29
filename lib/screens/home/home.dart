import 'dart:developer';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/object_detection/obj_det.dart';
import 'package:illusion/screens/speech_to_text/stt_page.dart';
import 'package:illusion/screens/text_to_speech/tts_page.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isMute = false;
  String _text = "Hey there! 👋\nHow can I help you?";
  List<String> errorTexts = [
    "I'm sorry, can you speak again?",
    "Didn't get it right, can you say that again?",
    "Can you please repeat that again?"
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      flutterTts.speak("Hey there! How can I help you?").then((value) {
        Future.delayed(const Duration(milliseconds: 2000), () {
          _listen();
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(size.height * 0.04),
                  child: Center(
                    child: Column(
                      children: [
                        Text("Illusion",
                            style: GoogleFonts.bebasNeue(
                              letterSpacing: 5,
                              color: Colours.primaryColor.withOpacity(0.8),
                              fontSize: size.height * 0.05,
                            )),
                        Text("Always At Your Service",
                            style: GoogleFonts.bebasNeue(
                              letterSpacing: 1,
                              color: Colors.black.withOpacity(0.3),
                              fontSize: size.height * 0.02,
                            )),
                      ],
                    ),
                  ),
                ),
                Center(
                    child: Lottie.asset(
                  "assets/robot.json",
                  height: size.height * 0.2,
                )),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: SizedBox(
                      height: size.height * 0.06,
                      child: Text(
                        _text,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: size.height * 0.0225,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(
                  child: AvatarGlow(
                    animate: !_isMute,
                    glowColor: Colors.indigoAccent,
                    endRadius: size.height * 0.05,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    repeat: true,
                    child: FloatingActionButton(
                      child: Icon(
                        _isMute ? CupertinoIcons.mic_off : CupertinoIcons.mic,
                        size: size.height * 0.03,
                        color: Colors.white54,
                      ),
                      backgroundColor: _isMute
                          ? Colours.primaryColor.withOpacity(.5)
                          : Colours.primaryColor.withOpacity(.35),
                      onPressed: () {
                        setState(() {
                          _isMute = !_isMute;
                        });

                        if (_isMute) {
                          if (mounted) {
                            setState(() {
                              _text = "Hey there! 👋\nHow can I help you?";
                            });
                          }
                          flutterTts.stop();
                          flutterStt.stop();
                        } else {
                          _listen();
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isMute) {
      bool available = await flutterStt.initialize(
        finalTimeout: Duration(seconds: 3),
        onStatus: (val) => log('onStatus: $val'),
        onError: (val) {
          log('onError: $val');
          if (val.errorMsg != 'error_busy') {
            Future.delayed(const Duration(milliseconds: 1000), () {
              errorTexts.shuffle();
              if (mounted) {
                setState(() {
                  _text = errorTexts[0];
                });
              }
              flutterTts.speak(errorTexts[0]).then((value) {
                flutterStt.stop();
                Future.delayed(Duration(milliseconds: 1500), () {
                  _listen();
                });
              });
            });
          }
        },
      );

      if (available) {
        flutterStt.listen(
            //TODO
            onSoundLevelChange: (sound) {},
            onResult: (val) async {
              if (mounted) {
                setState(() {
                  _text = val.recognizedWords;
                });
              }

              if (val.finalResult) {
                if (_text.toLowerCase().contains("see") ||
                    _text.toLowerCase().contains("help me see")) {
                  setState(() {
                    _isMute = true;
                    _text = "Hey there! 👋\nHow can I help you?";
                  });

                  await flutterTts.stop();
                  await flutterStt.stop();

                  //TODO
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ObjDetPage()));
                } else if (_text.toLowerCase().contains("speak") ||
                    _text.toLowerCase().contains("help me speak")) {
                  setState(() {
                    _isMute = true;
                    _text = "Hey there! 👋\nHow can I help you?";
                  });

                  await flutterTts.stop();
                  await flutterStt.stop();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TextToSpeechPage()));
                } else if (_text.toLowerCase().contains("hear") ||
                    _text.toLowerCase().contains("help me hear")) {
                  setState(() {
                    _isMute = true;
                    _text = "Hey there! 👋\nHow can I help you?";
                  });

                  await flutterTts.stop();
                  await flutterStt.stop();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SpeechToTextPage()));
                } else {
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    errorTexts.shuffle();
                    if (mounted) {
                      setState(() {
                        _text = errorTexts[0];
                      });
                    }
                    flutterTts.speak(errorTexts[0]).then((value) {
                      flutterStt.stop();
                      Future.delayed(const Duration(milliseconds: 2000), () {
                        _listen();
                      });
                    });
                  });
                }
              }
            });
      }
    }
  }
}
