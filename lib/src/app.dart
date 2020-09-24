import 'dart:ui';

import 'package:flutter/material.dart';
import './view/pages/pages.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ride App",
      home: HomePage(),
      theme: lightTheme(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      primaryColor: Color(0xFF657ED4),
      accentColor: Color(0xFF657ED4),
      scaffoldBackgroundColor: Color(0xFFF8F8F8),
      primaryColorDark: Color(0xFF444444),
      primaryColorLight: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Color(0xFFF8F8F8),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color(0xFF444444),
            letterSpacing: 5,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF444444),
        size: 20,
      ),
      textTheme: TextTheme(
        headline2: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xFF444444),
        ),
        headline3: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF444444),
        ),
        headline4: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: Color(0xFF444444),
        ),
        subtitle1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF444444),
        ),
        subtitle2: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.normal,
          color: Color(0xFF444444),
        ),
      ),
      primaryTextTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF657ED4),
        ),
        headline3: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        headline4: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Colors.white),
        subtitle1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        subtitle2: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.normal,
          color: Colors.red,
        ),
      ),
    );
  }
}
