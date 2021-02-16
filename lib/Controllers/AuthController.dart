import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macsentry/Controllers/VpnController.dart';
import 'package:macsentry/Views/HomeDrawer.dart';

//import 'package:mongo_dart/mongo_dart.dart';

class AuthController extends GetxController {
  // Intilize the flutter app

  final vpnController = Get.put(MSVpnController());

  // Future<void> initlizeFirebaseApp() async {
  //  firebaseApp = await Firebase.initializeApp();
  //   // await database.openDb();
  // }

  Future<Widget> checkUserLoggedIn() async {
    // if (firebaseApp == null) {
    //   await initlizeFirebaseApp();
    // }
    // if (firebaseAuth == null) {
    //  firebaseAuth = FirebaseAuth.instance;
    //  update();
    // }
    // if (firebaseAuth.currentUser == null) {
    await vpnController.getCred();
    return HomeDrawer();
    // } else {
    //  firebaseUser = firebaseAuth.currentUser;
    //  update();
    //   return HomeDrawer();
    //   //TODO
    //  }
  }
}
