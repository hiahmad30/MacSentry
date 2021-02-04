import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Controllers/AuthController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    @override
    Widget build(BuildContext context) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        builder: EasyLoading.init(),
        home: FutureBuilder(
          future: authController.checkUserLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error Processing');
            }
            if (snapshot.hasData) {
              return snapshot.data;
            }
            // return LoadingWidget();
          },
        ),
      );
    }
  }
}
