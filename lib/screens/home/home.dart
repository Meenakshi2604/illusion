import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/home/settings.dart';
import 'package:illusion/screens/home/support.dart';
import 'package:illusion/screens/object_detection/obj_det.dart';
import 'package:illusion/screens/speech_to_text/stt_page.dart';
import 'package:illusion/screens/text_to_speech/tts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _muteAI = false;

  _HomePageState() {
    //_initAlanButton();
  }

  void _initAlanButton() {
    AlanVoice.addButton(
        "36c8aaca9e477e818548a82b73a2c0012e956eca572e1d8b807a3e2338fdd0dc/stage");

    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
      var commandName = command.data["command"] ?? "";
      if (commandName == "showAlert") {
        /// handle command "showAlert"
      }
    });

    AlanVoice.onEvent.add((event) {
      debugPrint("got new event ${event.data.toString()}");
    });

    AlanVoice.onButtonState.add((state) {
      debugPrint("got new button state ${state.name}");
    });
  }

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
                      padding: const EdgeInsets.all(30.0),
                      child: Neumorphic(
                        style: const NeumorphicStyle(
                          depth: -5.0,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Illusion ✨",
                                style: GoogleFonts.lato(
                                  color: Colours.primaryColor.withOpacity(0.95),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                )),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                      height: 70,
                    ),
                    const Center(
                      child: Text(
                        "Hey there! 👋\nHow shall we help you?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
                                          const ObjDetPage()));
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
                                  Future.delayed(
                                      const Duration(milliseconds: 100), () {
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
                                  Future.delayed(
                                      const Duration(milliseconds: 100), () {
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
