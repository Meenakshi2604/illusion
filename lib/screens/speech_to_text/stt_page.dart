import 'dart:developer';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/navbar/navbar.dart';
import 'package:lottie/lottie.dart';

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({Key? key}) : super(key: key);

  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  bool _isMute = true;
  final ScrollController _scrollController = ScrollController();
  List<String> _texts = [];

  @override
  void initState() {
    super.initState();
    flutterTts.speak("Press the microphone button to start listening");
    NavBarState.changer.addListener(_listener);
  }

  @override
  void dispose() {
    NavBarState.changer.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (NavBarState.controller.index == 2) {
      _listen();
      if (_isMute)
        flutterTts.speak("Press the microphone button to start listening");
    } else if (NavBarState.controller.index == 0) {
      setState(() {
        _isMute = true;
      });
    }
  }

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
              if (mounted)
                setState(() {
                  _isMute = !_isMute;
                });
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
                      _isMute
                          ? "Press the microphone button to start listening"
                          : "Listening...",
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
    if (!_isMute) {
      if (mounted) {
        setState(() {
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
          flutterStt.stop();
          _listen();
        }
      };

      bool available = await flutterStt.initialize();

      if (available) {
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
                flutterStt.stop();
                _listen();
              }
            });
      }
    } else {
      flutterStt.stop();
    }
  }
}
