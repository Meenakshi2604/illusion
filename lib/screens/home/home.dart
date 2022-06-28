import 'dart:developer';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/home/settings.dart';
import 'package:illusion/screens/home/support.dart';
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
      body: Neumorphic(
        style: const NeumorphicStyle(
          depth: -5.0,
        ),
        child: SafeArea(
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
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 30,
                      right: 30,
                    ),
                    child: Neumorphic(
                      style: const NeumorphicStyle(
                        depth: -5.0,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Illusion",
                                style: TextStyle(
                                  color: Colours.primaryColor.withOpacity(0.95),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Image.asset(
                                "assets/icon.png",
                                height: size.height * 0.07,
                              ))
                            ],
                          ),
                        ),
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
                    child: SizedBox(
                      height: size.height * 0.15,
                      width: size.width * 0.35,
                      child: NeumorphicButton(
                        child: Text(
                          "Help me\nsee\n\n👁👁",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colours.tertiaryColor,
                            fontSize: size.height * 0.025,
                          ),
                        ),
                        onPressed: () {
                          Future.delayed(const Duration(milliseconds: 100),
                              () async {
                            setState(() {
                              _isMute = true;
                              _text = "Hey there! 👋\nHow can I help you?";
                            });

                            await flutterTts.stop();
                            await flutterStt.stop();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ObjDetPage()));
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: SizedBox(
                            height: size.height * 0.15,
                            width: size.width * 0.35,
                            child: NeumorphicButton(
                              child: Text(
                                "Help me\nspeak\n\n🗣",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colours.tertiaryColor,
                                  fontSize: size.height * 0.025,
                                ),
                              ),
                              onPressed: () {
                                Future.delayed(
                                    const Duration(milliseconds: 100),
                                    () async {
                                  setState(() {
                                    _isMute = true;
                                    _text =
                                        "Hey there! 👋\nHow can I help you?";
                                  });

                                  await flutterTts.stop();
                                  await flutterStt.stop();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TextToSpeechPage()));
                                });
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: size.height * 0.15,
                            width: size.width * 0.35,
                            child: NeumorphicButton(
                              child: Text(
                                "Help me\nhear\n\n👂",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colours.tertiaryColor,
                                  fontSize: size.height * 0.025,
                                ),
                              ),
                              onPressed: () {
                                Future.delayed(
                                    const Duration(milliseconds: 100),
                                    () async {
                                  setState(() {
                                    _isMute = true;
                                    _text =
                                        "Hey there! 👋\nHow can I help you?";
                                  });

                                  await flutterTts.stop();
                                  await flutterStt.stop();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SpeechToTextPage()));
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NeumorphicButton(
                          tooltip: 'Settings',
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            CupertinoIcons.settings,
                            size: size.height * 0.03,
                            color: Colours.tertiaryColor,
                          ),
                          onPressed: () {
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => const SettingsPage());
                            });
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        NeumorphicButton(
                          tooltip: 'Voice Assistant',
                          padding: const EdgeInsets.all(5),
                          child: AvatarGlow(
                            animate: !_isMute,
                            glowColor: Colors.indigoAccent,
                            endRadius: _isMute
                                ? size.height * 0.0225
                                : size.height * 0.025,
                            repeatPauseDuration:
                                const Duration(milliseconds: 100),
                            repeat: true,
                            duration: const Duration(milliseconds: 1000),
                            child: Icon(
                              _isMute
                                  ? CupertinoIcons.mic_off
                                  : CupertinoIcons.mic,
                              size: _isMute
                                  ? size.height * 0.03
                                  : size.height * 0.033,
                              color: Colours.tertiaryColor,
                            ),
                          ),
                          onPressed: () {
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              setState(() {
                                _isMute = !_isMute;
                              });

                              if (_isMute) {
                                if (mounted) {
                                  setState(() {
                                    _text =
                                        "Hey there! 👋\nHow can I help you?";
                                  });
                                }
                                flutterTts.stop();
                                flutterStt.stop();
                              } else {
                                _listen();
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        NeumorphicButton(
                          tooltip: 'Support',
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            CupertinoIcons.question_circle,
                            size: size.height * 0.03,
                            color: Colours.tertiaryColor,
                          ),
                          onPressed: () {
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => const SupportPage());
                            });
                          },
                        ),
                      ],
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
                Future.delayed(const Duration(milliseconds: 2000), () {
                  _listen();
                });
              });
            });
          }
        },
      );

      if (available) {
        flutterStt.listen(
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
