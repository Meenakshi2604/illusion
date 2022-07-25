import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:illusion/screens/navbar/navbar.dart';
import 'package:speech_to_text/speech_to_text.dart';

final SpeechToText flutterStt = SpeechToText();
final FlutterTts flutterTts = FlutterTts();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Illusion',
      theme: ThemeData(
          primaryColor: Colours.primaryColor,
          textTheme: GoogleFonts.abelTextTheme(
            Theme.of(context).textTheme,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colours.primaryColor,
          )),
      home: const NavBar(),
    );
  }
}

class Colours {
  static const Color backgroundColor = Color(0xFFDDE6E8);
  static const Color primaryColor = Colors.indigoAccent;
  static const Color secondaryColor = Colors.purple;
  static final Color tertiaryColor = Colors.grey[700]!;
}
