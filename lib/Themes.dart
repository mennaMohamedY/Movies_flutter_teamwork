import 'package:flutter/material.dart';

class MyTheme {
  static Color sectionsGrey = Color(0xff514F4F);
  static Color bottomNav = Color(0xff232323);
  static Color yellow = Color(0xffFFB224);

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
          titleMedium: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
          titleSmall: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400)));
}
