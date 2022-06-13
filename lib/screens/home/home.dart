import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/home/settings.dart';
import 'package:illusion/screens/home/support.dart';
import 'package:illusion/screens/object_detection/camera_page.dart';
import 'package:illusion/screens/speech_to_text/stt_page.dart';
import 'package:illusion/screens/text_to_speech/tts_page.dart';

import '../object_detection/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _muteAI = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Neumorphic(
            style: const NeumorphicStyle(
              depth: -5.0,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Neumorphic(
                        style: const NeumorphicStyle(
                          depth: -5.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                fontSize: 40,
                              ),
                              children: [
                                TextSpan(
                                    text: "Illusion",
                                    style: GoogleFonts.dancingScript(
                                      color: Colours.primaryColor
                                          .withOpacity(0.95),
                                      fontWeight: FontWeight.bold,
                                    )),
                                const TextSpan(
                                  text: " is here to help you out ✨",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 140,
                        child: NeumorphicButton(
                          child: Text(
                            "Help me\nsee\n\n👁👁",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colours.tertiaryColor,
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeView()));
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 140,
                        child: NeumorphicButton(
                          child: Text(
                            "Help me\nspeak\n\n🗣",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colours.tertiaryColor,
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
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
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 140,
                        child: NeumorphicButton(
                          child: Text(
                            "Help me\nhear\n\n👂",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colours.tertiaryColor,
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
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
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeumorphicButton(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              _muteAI
                                  ? CupertinoIcons.mic_off
                                  : CupertinoIcons.mic,
                              size: 30,
                              color: Colours.tertiaryColor,
                            ),
                            onPressed: () {
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                setState(() {
                                  _muteAI = !_muteAI;
                                });
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          NeumorphicButton(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              CupertinoIcons.settings,
                              size: 30,
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
                            width: 20,
                          ),
                          NeumorphicButton(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              CupertinoIcons.question_circle,
                              size: 30,
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
                      height: 30,
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
}
