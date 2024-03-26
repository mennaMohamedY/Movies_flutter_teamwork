import 'package:flutter/material.dart';

class MyTheme {
  static Color sectionsGrey = Color(0xff514F4F);
  static Color bottomNav = Color(0xff232323);
  static Color yellowColor = Color(0xffFFB224);
  static Color bordersColor = Color(0xff5C5C5C);
  static Color blackColor = Color(0xff1E1E1E);
  static Color greyColor = Color(0xff636363);
  static Color darkGreyColor = Color(0xff282A28);
  static Color whiteColor = Color(0xffffffff);
  static Color lightGreyColor = Color(0xffB5B4B4);

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
        color: Colors.black,
        centerTitle: true,
        iconTheme: IconThemeData(color: MyTheme.whiteColor)),
  );
}
