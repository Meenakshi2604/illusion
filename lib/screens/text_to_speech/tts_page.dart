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

  String userPost = '';
  speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(userPost);
  }

  @override
  void initState() {
    super.initState();
    flutterTts.speak('Type something and press the play button to speak');
    NavBarState.changer.addListener(_listener);
  }

  @override
  void dispose() {
    NavBarState.changer.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (NavBarState.controller.index == 3)
      flutterTts.speak('Type something and press the play button to speak');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          _isReady = false;
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colours.backgroundColor,
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
                      Text(
                        'Type something and press the play button to speak',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.height * 0.020,
                          color: Colors.black38,
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
                                fontSize: 24,
                                color: Colors.black87,
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
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _textController,
                  onChanged: (text) {
                    if (text.trim().isNotEmpty && mounted)
                      setState(() {
                        _isReady = true;
                      });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colours.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colours.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.play_arrow_rounded,
                            color: _isReady ? Colours.primaryColor : null,
                          ),
                          splashRadius: 20,
                          onPressed:
                              _isReady && _textController.text.trim().isNotEmpty
                                  ? () {
                                      setState(() {
                                        userPost = _textController.text;
                                        _textController.clear();
                                        _isReady = false;
                                        speak();
                                      });
                                    }
                                  : null)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
