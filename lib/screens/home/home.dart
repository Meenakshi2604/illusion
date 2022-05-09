import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:illusion/main.dart';

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
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            right: 10,
                          ),
                          child: NeumorphicButton(
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
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        height: 140,
                        width: 160,
                        child: NeumorphicButton(
                          child: Text(
                            "Help me\nsee\n\n👁👁",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colours.tertiaryColor,
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        height: 140,
                        width: 160,
                        child: NeumorphicButton(
                          child: Text(
                            "Help me\nspeak\n\n🗣",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colours.tertiaryColor,
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        height: 140,
                        width: 160,
                        child: NeumorphicButton(
                          child: Text(
                            "Help me\nhear\n\n👂",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colours.tertiaryColor,
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {},
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
                            CupertinoIcons.settings,
                            size: 30,
                            color: Colours.tertiaryColor,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        NeumorphicButton(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            CupertinoIcons.flag,
                            size: 30,
                            color: Colours.tertiaryColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    )),
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
