import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/tela_pilotos.dart';

class F1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "F1 App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF111111),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFE8002D),
          secondary: Color(0xFFE8002D),
        ),
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF111111),
          centerTitle: true,
          titleTextStyle: GoogleFonts.roboto(
            color: Color(0xFFE8002D),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      home: TelaPilotos(),
    );
  }
}