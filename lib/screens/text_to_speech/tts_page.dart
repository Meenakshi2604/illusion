import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:illusion/main.dart';
import 'package:lottie/lottie.dart';

class TextToSpeechPage extends StatefulWidget {
  const TextToSpeechPage({Key? key}) : super(key: key);

  @override
  _TextToSpeechPageState createState() => _TextToSpeechPageState();
}

class _TextToSpeechPageState extends State<TextToSpeechPage> {
  final _textController = TextEditingController();

  String userPost = 'Type something and press the play button';
  speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.3);
    await flutterTts.speak(_textController.text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Neumorphic(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Center(
                  child: Lottie.asset(
                "assets/robot.json",
                height: size.height * 0.2,
              )),

              //display text
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    userPost,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),

              const Spacer(),

              //user input text field
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colours.primaryColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colours.primaryColor)),
                      suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colours.primaryColor,
                          ),
                          onPressed: () {
                            //=> speak();
                            setState(() {
                              userPost = _textController.text;
                              speak();
                              if (userPost == '') {
                                userPost =
                                    'Type something and press the play button';
                              }
                            });
                          })),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
