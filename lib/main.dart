import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:illusion/screens/home/home.dart';

void main() {
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
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class Colours {
  static const Color backgroundColor = Colors.white;
  static const Color primaryColor = Colors.indigoAccent;
  static const Color secondaryColor = Colors.purple;
  static final Color tertiaryColor = Colors.grey[700]!;
}
