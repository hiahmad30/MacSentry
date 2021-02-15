import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyResources {
  static Color primaryColor = Color(0xfff5f5f5);
  static Color backgroundColor = Colors.white;
  static Color appBarActionsColor = Colors.white;

  static Color sideBarColor = Color(0xfff5f5f5);
  static Color buttonColor = Color(0xffebebeb);
  static Color hintColor = Color(0xffd2d2d2);
  static Color loginBtnColor = Color(0xff5DB075);
  static Color registerBtnColor = Color(0xff30BCED);

  static TextStyle appTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  static TextStyle appHeadingStylemini =
      GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500);
  static TextStyle appHeadingStyle = TextStyle(
      fontSize: 40, fontWeight: FontWeight.w500, color: Colors.black87);
  static TextStyle appsignuploginlink =
      GoogleFonts.roboto(fontSize: 14, color: Color(0xff5DB075));

  static TextStyle hintfontStyle =
      GoogleFonts.roboto(fontSize: 16, color: hintColor);
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
