import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyResources {
  static Color primaryColor = Color(0xfff5f5f5);
  static Color backgroundColor = Color(0xfff5f5f5);

  static Color sideBarColor = Color(0xfff5f5f5);
  static Color buttonColor = Color(0xffebebeb);
  static Color hintColor = Color(0xffd2d2d2);
  static Color loginBtnColor = Color(0xff5DB075);
  static Color registerBtnColor = Color(0xff30BCED);

  static TextStyle appTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
  static TextStyle appHeadingStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.w600, color: Color(0xff555555));
  static TextStyle appsignuploginlink =
      GoogleFonts.inter(fontSize: 14, color: Color(0xff5DB075));

  static TextStyle hintfontStyle =
      GoogleFonts.inter(fontSize: 16, color: hintColor);
  static TextStyle textStyleprofile = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle myTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  ///////////////////////Input Decoration////////////////
  static InputDecoration textFieldBorder = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
  static BoxDecoration boxDecoration = BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10));
}
