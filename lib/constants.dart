import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyResources {
  static Color primaryColor = Color(0xfff5f5f5);
  static Color backgroundColor = Colors.white;
  static Color appBarActionsColor = Colors.white;

  static Color HeadingColor = Colors.orange;
  static Color coachHeading = Colors.blue;
  static Color sideBarColor = Color(0xfff5f5f5);
  static Color buttonColor = Color(0xffebebeb);
  static Color hintColor = Color(0xffd2d2d2);

  static TextStyle appTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    color: Colors.black,
  );
  static TextStyle appHeadingStyle = GoogleFonts.roboto(
    fontSize: 23,
    fontWeight: FontWeight.bold,
  );
  static TextStyle appHeadingStylemini =
      GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500);
  static TextStyle appHeadingStyleLogin = GoogleFonts.roboto(
      fontSize: 23, fontWeight: FontWeight.bold, color: Colors.orange);
  static TextStyle appsignuploginlink =
      GoogleFonts.roboto(fontSize: 14, color: Colors.blue);

  static TextStyle hintfontStyle =
      GoogleFonts.roboto(fontSize: 14, color: hintColor);
  static TextStyle textStyleprofile = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle myTextStyle = GoogleFonts.roboto(
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
