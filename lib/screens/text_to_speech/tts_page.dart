import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechPage extends StatefulWidget {
  const TextToSpeechPage({Key? key}) : super(key: key);

  @override
  _TextToSpeechPageState createState() => _TextToSpeechPageState();
}

class _TextToSpeechPageState extends State<TextToSpeechPage> {
  final _textController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  String userPost = 'Type something and press the play button';
  speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.3);
    await flutterTts.speak(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //display text
            Expanded(
                child: Container(
                    child: Center(
              child: Text(
                userPost,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35),
              ),
            ))),

            //user input text field
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.play_arrow_rounded),
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
            )
          ],
        ),
      ),
    );
  }
}
