import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:illusion/screens/navbar/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

final SpeechToText flutterStt = SpeechToText();
final FlutterTts flutterTts = FlutterTts();
bool isDark = false;
bool assistantOn = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await flutterTts.setLanguage("en-IN");
  await flutterTts.setPitch(1);

  final prefs = await SharedPreferences.getInstance();

  isDark = await prefs.getBool('isDark') ?? false;

  assistantOn = await prefs.getBool('assistantOn') ?? true;
  
  if (assistantOn) {
    flutterTts.setVolume(1);
  } else {
    flutterTts.setVolume(0);
  }

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
        backgroundColor:
            isDark ? Colours.darkBackgroundColor : Colours.backgroundColor,
        primaryColor: Colours.primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colours.primaryColor,
        ),
      ),
      home: const NavBar(),
    );
  }
}

class Colours {
  static const Color backgroundColor = Color(0xFFDDE6E8);
  static const Color darkBackgroundColor = Colors.black87;
  static const Color primaryColor = Colors.indigoAccent;
  static const Color darkPrimaryColor = Colors.lightBlueAccent;
  static const Color secondaryColor = Colors.purple;
  static final Color tertiaryColor = Colors.grey[700]!;
  static final Color textColor = Colors.black87;
  static final Color darkTextColor = Colors.white70;
}
