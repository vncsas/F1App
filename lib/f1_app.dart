import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

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
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF111111),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFE8002D), 
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      home: SplashScreen(),   
    );
  }
}