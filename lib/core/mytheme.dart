import 'package:flutter/material.dart';

class MyTheme {
//! english light
  static final lightthemeenglish = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontFamily: "Dancing",
          color: Colors.red,
          fontSize: 35,
          fontWeight: FontWeight.bold),
      headline2: TextStyle(
          fontFamily: "oswalad",
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold),
//  headline3: const TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold) ,

      //?body text 1
      bodyText1: TextStyle(
          fontFamily: "oswalad",
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.normal),

//  bodyText2:     TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),

      subtitle1: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
    ),
    colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 30, 30, 43),
        secondary: Color.fromARGB(255, 30, 30, 43)),
  );
//! english dark
  static final darkthemeenglish = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontFamily: "Dancing",
          color: Color.fromARGB(255, 179, 200, 241),
          fontSize: 36,
          fontWeight: FontWeight.bold),
      headline2: TextStyle(
          fontFamily: "oswalad",
          color: Color.fromARGB(255, 179, 200, 241),
          fontSize: 20,
          fontWeight: FontWeight.bold),
//  headline3: const TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold) ,
      bodyText1: TextStyle(
          fontFamily: "oswalad",
          color: Color.fromARGB(255, 179, 200, 241),
          fontSize: 20,
          fontWeight: FontWeight.normal),

//  bodyText2:     TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),

      subtitle1: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
    ),
    colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 30, 30, 43),
        secondary: Color.fromARGB(255, 30, 30, 43)),
  );

//! arabic light
  static final lightthemearabic = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontFamily: "cairo",
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      headline2: TextStyle(
          fontFamily: "cairo",
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold),
//  headline3: const TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold) ,
      bodyText1: TextStyle(
          fontFamily: "cairo",
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal),

//  bodyText2:     TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),

      subtitle1: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
    ),
    colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: Colors.amber,
        secondary: Colors.amber),
  );
//! arabic dark
  static final darkthemearabic = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontFamily: "cairo",
            color: Color.fromARGB(255, 179, 200, 241),
            fontSize: 20,
            fontWeight: FontWeight.bold),
        headline2: TextStyle(
            fontFamily: "cairo",
            color: Color.fromARGB(255, 179, 200, 241),
            fontSize: 20,
            fontWeight: FontWeight.bold),
//  headline3: const TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold) ,
        bodyText1: TextStyle(
            fontFamily: "cairo",
            color: Color.fromARGB(255, 179, 200, 241),
            fontSize: 16,
            fontWeight: FontWeight.normal),

//  bodyText2:     TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),

        subtitle1: TextStyle(
            color: Color.fromARGB(255, 179, 200, 241),
            fontSize: 14,
            fontWeight: FontWeight.normal),
      ),
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 30, 30, 43),
        secondary: Color.fromARGB(255, 30, 30, 43),
      ));
}
