import 'package:flutter/material.dart';

class TextToSpeechPage extends StatefulWidget {
  const TextToSpeechPage({Key? key}) : super(key: key);

  @override
  _TextToSpeechPageState createState() => _TextToSpeechPageState();
}

class _TextToSpeechPageState extends State<TextToSpeechPage> {
  @override
  Widget build(BuildContext context) {
    var hintText2 = 'Type Something';
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child : TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: (null),
              )
           // hintText: hintText2,
            ),
          ),
        ),
      ]),
    );
  }
}
