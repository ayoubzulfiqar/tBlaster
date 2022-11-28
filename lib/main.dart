import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_blaster/screens/welcome.dart';

void main() {
  runApp(const TBlaster());
}

class TBlaster extends StatelessWidget {
  const TBlaster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "T Blaster",
      themeMode: ThemeMode.system,
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const Welcome(),
    );
  }
}
