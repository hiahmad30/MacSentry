import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macsentry/constants.dart';

import 'Controllers/AuthController.dart';
import 'Views/ButtonWidget.dart';
import 'Views/opebntest.dart';

void main() {
  runApp(PercentIndicatorWidget());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.aBeeZeeTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: Color(0xff30303A),
        primaryColorDark: MyResources.loginBtnColor,
      ),
      //   builder: EasyLoading.init(),
      home: FutureBuilder(
        future: authController.checkUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error Processing');
          }
          if (snapshot.hasData) {
            return snapshot.data;
          }
          return SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
