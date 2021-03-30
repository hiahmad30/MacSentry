import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import '../purchase.dart';
import 'package:http/http.dart';
import 'package:macsentry/Controllers/SubscriptionController.dart';
import 'package:macsentry/Controllers/VpnController.dart';
import 'package:macsentry/Views/HomeDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:mongo_dart/mongo_dart.dart';

class AuthController extends GetxController {
  // Intilize the flutter app

  RxString userEmail = ''.obs;
  RxString pass = ''.obs;
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
    // await vpnController.getCred();

    return InAppPurchase();
    // } else {
    //  firebaseUser = firebaseAuth.currentUser;
    //  update();
    //   return HomeDrawer();
    //   //TODO
    //  }
  }

  Future<bool> loginRequest(String username, String password) async {
    String trId = '122112';
    vpnController.isConneString = 'Connecting'.obs;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString('userName', username);
      prefs.setString('password', password);
      prefs.setString('trId', trId);
      await vpnController.getHttp(username, password, trId).then((value) async {
        await vpnController
            .connectVpn(value['user'].toString(), value['password'].toString())
            .then((value) => Get.to(() => HomeDrawer()));
      });
    } catch (ex) {
      Get.back();
      print(ex.toString());
      Get.defaultDialog(title: 'Http Error', content: Text(ex.toString()));
      return false;
    }
  }

  Future<bool> checkAlready() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vpnController.isConneString.value = 'Connecting';

    try {
      String trId = prefs.getString('trId');
      String username = prefs.getString('userName');
      String password = prefs.getString('password');
      await vpnController.getHttp(username, password, trId).then((value) async {
        await vpnController
            .connectVpn(value['user'].toString(), value['password'].toString())
            .then((value) => Get.to(() => HomeDrawer()));
        return true;
      });
    } catch (ex) {
      Get.back();
      print(ex.toString());
      Get.defaultDialog(title: 'Http Error', content: Text(ex.toString()));
      return false;
    }
  }

  Future<void> logOutCred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.remove('password');
      prefs.remove('user');
      prefs.remove('trId');
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }
}
