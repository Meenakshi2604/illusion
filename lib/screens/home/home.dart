import 'dart:developer';
import 'dart:ui';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/navbar/navbar.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isMute = false;
  bool _flag = false;
  double _height = 0;
  String _text = "Hey there! 👋\nHow can I help you?";
  List<String> errorTexts = [
    "I'm sorry, can you speak again?",
    "Didn't get it right, can you say that again?",
    "Can you please repeat that again?"
  ];

  @override
  void initState() {
    super.initState();
    NavBarState.changer.addListener(_listener);
    Future.delayed(const Duration(milliseconds: 1500), () {
      flutterTts.speak("Hey there! How can I help you?").then((value) {
        _listen();
      });
    });
  }

  @override
  void dispose() {
    NavBarState.changer.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (NavBarState.controller.index == 0) {
      if (mounted)
        setState(() {
          _text = "Hey there! 👋\nHow can I help you?";
          if (_flag) {
            _isMute = false;
            _flag = false;
          }
        });
      flutterTts.speak("Hey there! How can I help you?").then((value) {
        _listen();
      });
    } else if (NavBarState.controller.index == 2 && !_isMute && mounted)
      setState(() {
        _isMute = true;
        _flag = true;
      });
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
                  height: size.height * 0.01,
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

                        _listen();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.15,
                ),
                if (!_isMute)
                  CustomPaint(
                    painter: SoundPainter(
                      path: drawPath(_height),
                    ),
                  ),
                if (!_isMute)
                  CustomPaint(
                    painter: SoundPainter(
                      path: drawPath(_height / 2),
                    ),
                  ),
                if (!_isMute)
                  CustomPaint(
                    painter: SoundPainter(
                      path: drawPath(-_height / 2),
                    ),
                  ),
                if (!_isMute)
                  CustomPaint(
                    painter: SoundPainter(
                      path: drawPath(0.0),
                    ),
                  ),
                if (!_isMute)
                  CustomPaint(
                    painter: SoundPainter(
                      path: drawPath(-_height),
                    ),
                  ),
                SizedBox(
                  height: size.height * 0.05,
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
          if (mounted)
            setState(() {
              _height = 0;
            });
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
                _listen();
              });
            });
          }
        },
      );

      if (available) {
        flutterStt.listen(onSoundLevelChange: (sound) {
          if (mounted && sound != 10 && sound != -2)
            setState(() {
              _height = sound * 15;
            });
        }, onResult: (val) async {
          if (mounted) {
            setState(() {
              _text = val.recognizedWords;
            });
          }

          if (val.finalResult) {
            if (mounted)
              setState(() {
                _height = 0;
              });

            if (_text.toLowerCase().contains("see") ||
                _text.toLowerCase().contains("detect") ||
                _text.toLowerCase().contains("visual") ||
                _text.toLowerCase().contains("blind")) {
              NavBarState.controller.jumpToTab(1);
              NavBarState.changer.notify();
            } else if (_text.toLowerCase().contains("hear") ||
                _text.toLowerCase().contains("listen") ||
                _text.toLowerCase().contains("deaf")) {
              NavBarState.controller.jumpToTab(2);
            } else if (_text.toLowerCase().contains("speak") ||
                _text.toLowerCase().contains("say") ||
                _text.toLowerCase().contains("talk") ||
                _text.toLowerCase().contains("speech") ||
                _text.toLowerCase().contains("dumb")) {
              NavBarState.controller.jumpToTab(3);
            } else if (_text.toLowerCase().contains("stop") ||
                _text.toLowerCase().contains("mute") ||
                _text.toLowerCase().contains("end") ||
                _text.toLowerCase().contains("quit") ||
                _text.toLowerCase().contains("bye") ||
                _text.toLowerCase().contains("no")) {
              if (mounted)
                setState(() {
                  _isMute = true;
                  flutterStt.stop();
                });
            } else if (_text.toLowerCase().contains("thank")) {
              flutterTts
                  .speak("Illusion is always at your service!")
                  .then((value) {
                flutterStt.stop();
                _listen();
              });
            } else if (_text.toLowerCase().contains("hi") ||
                _text.toLowerCase().contains("hey") ||
                _text.toLowerCase().contains("hello")) {
              flutterTts.speak("Hey there! How can I help you!").then((value) {
                flutterStt.stop();
                _listen();
              });
            } else if (_text.toLowerCase().contains("ok") ||
                _text.toLowerCase().contains("yes")) {
              flutterStt.stop();
              _listen(); ||
          _text.toLowerCase().contains("bye")
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
                  _listen();
                });
              });
            }
          }
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _text = "Hey there! 👋\nHow can I help you?";
          _height = 0;
        });
      }
      flutterTts.stop();
      flutterStt.stop();
    }
  }

  Path drawPath(height) {
    final width = MediaQuery.of(context).size.width;
    final path = Path();
    final segmentWidth = width / 3 / 2;
    path.moveTo(0, 0);
    path.cubicTo(
        segmentWidth, 0, 2 * segmentWidth, height, 3 * segmentWidth, height);
    path.cubicTo(
        4 * segmentWidth, height, 5 * segmentWidth, 0, 6 * segmentWidth, 0);
    return path;
  }
}

class SoundPainter extends CustomPainter {
  Path path;
  SoundPainter({required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    // paint the line
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
