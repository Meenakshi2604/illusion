import 'package:flutter/material.dart';
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
  bool _isReady = false;
  bool _isFocused = false;
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

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          _textController.clear();
          _isReady = false;
          currentFocus.unfocus();

          Future.delayed(Duration(milliseconds: 200), () {
            if (mounted)
              setState(() {
                _isFocused = false;
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
              //display text
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
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
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

              //user input text field
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  bottom: _isFocused ? size.height * 0.05 : size.height * 0.15,
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
                        _isFocused = true;
                      });
                  },
                  onSubmitted: (text) {
                    Future.delayed(Duration(milliseconds: 200), () {
                      if (mounted)
                        setState(() {
                          _isFocused = false;
                        });
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: isDark
                                ? Colours.darkPrimaryColor
                                : Colours.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[700]!,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: isDark
                                ? Colours.darkPrimaryColor
                                : Colours.primaryColor),
                        borderRadius: BorderRadius.circular(10),
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
                          onPressed:
                              _isReady && _textController.text.trim().isNotEmpty
                                  ? () async {
                                      setState(() {
                                        userPost = _textController.text;
                                        _textController.clear();
                                        _isReady = false;
                                      });
                                      await flutterTts.speak(userPost);
                                    }
                                  : null)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
