import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:illusion/main.dart';
import 'package:illusion/screens/navbar/navbar.dart';
import 'package:lottie/lottie.dart';

class TextToSpeechPage extends StatefulWidget {
  const TextToSpeechPage({Key? key}) : super(key: key);

  @override
  _TextToSpeechPageState createState() => _TextToSpeechPageState();
}

class _TextToSpeechPageState extends State<TextToSpeechPage> {
  final _textController = TextEditingController();
  double _padding = 0.12;
  bool _isReady = false;
  String userPost = '';

  @override
  void initState() {
    super.initState();
    flutterTts.stop();
    flutterTts.speak('Type something and press the play button to speak');
    NavBarState.changer.addListener(_listener);
  }

  @override
  void dispose() {
    NavBarState.changer.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (NavBarState.controller.index == 3) {
      Future.delayed(Duration(milliseconds: 200), () {
        flutterTts.speak('Type something and press the play button to speak');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      if (isKeyboardVisible)
        _padding = 0.01;
      else {
        _padding = 0.12;
      }
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();

            Future.delayed(Duration(milliseconds: 200), () {
              if (mounted)
                setState(() {
                  _padding = 0.12;
                });
            });
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor:
                isDark ? Colours.darkBackgroundColor : Colours.backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          "assets/robot.json",
                          height: size.height * 0.15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                          ),
                          child: Text(
                            'Type something and press the play button to speak',
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.height * 0.020,
                              color: isDark
                                  ? Colours.darkTextColor.withOpacity(0.5)
                                  : Colours.textColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                userPost,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.height * 0.024,
                                  color: isDark
                                      ? Colours.darkTextColor
                                      : Colours.textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 0,
                    bottom: size.height * _padding,
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _textController,
                    style: TextStyle(
                      color: isDark ? Colours.darkTextColor : Colours.textColor,
                    ),
                    onChanged: (text) {
                      if (text.trim().isNotEmpty && mounted)
                        setState(() {
                          _isReady = true;
                        });
                      else if (mounted)
                        setState(() {
                          _isReady = false;
                        });
                    },
                    onTap: () {
                      if (mounted)
                        setState(() {
                          _padding = 0.01;
                        });
                    },
                    onSubmitted: (text) {
                      Future.delayed(Duration(milliseconds: 200), () {
                        if (mounted)
                          setState(() {
                            _padding = 0.12;
                          });
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDark
                                  ? Colours.darkPrimaryColor
                                  : Colours.primaryColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[700]!,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDark
                                  ? Colours.darkPrimaryColor
                                  : Colours.primaryColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.play_arrow_rounded,
                              color: _isReady
                                  ? isDark
                                      ? Colours.darkPrimaryColor
                                      : Colours.primaryColor
                                  : Colors.grey[700],
                            ),
                            splashRadius: 20,
                            onPressed: _isReady &&
                                    _textController.text.trim().isNotEmpty
                                ? () async {
                                    setState(() {
                                      userPost = _textController.text;
                                      _textController.clear();
                                      _isReady = false;
                                    });
                                    flutterTts.setVolume(1);
                                    await flutterTts.speak(userPost);
                                    if (!assistantOn) {
                                      flutterTts.setVolume(0);
                                    }
                                  }
                                : null)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
