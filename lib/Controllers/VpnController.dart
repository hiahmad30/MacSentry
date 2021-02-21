import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openvpn/flutter_openvpn.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MSVpnController extends GetxController {
  RxString isConneString = 'Connect'.obs;
  //TODO
  RxBool isConnected = false.obs;
  RxString userEmail = ''.obs;
  RxString pass = ''.obs;
  RxDouble connectLoad = 0.0.obs;
  RxString selectedContry = 'Canada'.obs;
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future connectVpn(String _email, String _pass) async {
    if (isConnected.value == false) {
      FlutterOpenvpn.init(
        localizedDescription: "MacSentry",
        providerBundleIdentifier: "com.engra.macsentry",
      ).then((value) {
        isConneString.value = 'Connecting';
      });

      await initPlatformState(_email, _pass);
    }
  }

  Future disconnectVpn() async {
    isConneString.value = 'Disconnecting';

    if (isConnected.value == true) {
      await FlutterOpenvpn.stopVPN().then((value) {});
    }
  }

  Future<void> initPlatformState(String email, String password) async {
    await saveCred(email, password);
    var contennt = await rootBundle.loadString('assets/1.ovpn');

    await FlutterOpenvpn.lunchVpn(contennt, (isProfileLoaded) {
      print('isProfileLoaded : $isProfileLoaded');
      //connectLoad.value = 0.5;
      // Get.defaultDialog(
      //   title: "Profile Connected",
      //   content: Text(isProfileLoaded.toString()),
      // );
    }, (vpnActivated) {
      print('vpnActivated : $vpnActivated');
      if (vpnActivated == 'WAIT') {
        connectLoad.value = 0.4;
      }
      if (vpnActivated == 'AUTH') {
        connectLoad.value = 0.6;
      }
      if (vpnActivated == 'ASSIGN_IP') {
        connectLoad.value = 0.8;
      }
      if (vpnActivated == 'DISCONNECTED') {
        isConneString.value = 'Connect';
        if (connectLoad.value != 0.0) connectLoad.value = 0.0;
        isConnected.value = false;
      } else if (vpnActivated == 'CONNECTED') {
        if (connectLoad.value != 1.0) connectLoad.value = 1.0;
        isConnected.value = true;
        isConneString.value = 'Disconnect';
      }
    },
        user: email,
        pass: password,
        onConnectionStatusChanged:
            (duration, lastPacketRecieve, byteIn, byteOut) => print(byteIn),
        expireAt: DateTime.now().add(
          Duration(
            minutes: 1,
          ),
        ));
  }

  /////////////////////////////////sAVE DATA
  Future<bool> saveCred(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString('userName', username);
      return prefs.setString('password', password);
    } catch (ex) {
      return false;
    }
  }

  Future<void> getCred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      userEmail.value = prefs.getString('userName');
      pass.value = prefs.getString('password');
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }

  Future<void> logOutCred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.remove('password');
      prefs.remove('userName');
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }

  @override
  Future<void> onReady() async {
    await getCred();
    // TODO: implement onReady
    super.onReady();
  }
  //

  @override
  Future<void> onInit() async {
    await fetchPost();
    super.onInit();
  }

  @override
  void onClose() {
    FlutterOpenvpn.stopVPN();
    // TODO: implement onClose
    super.onClose();
  } ////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
  List<dynamic> _postList = new List<dynamic>();

  Future<List<dynamic>> fetchPost() async {
    try {
      final response =
          await http.get('https://www.macsentry.com/config/serverList.php');

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        Map<String, dynamic> values = json.decode(response.body);
        if (values != null) {
          values.forEach((key, value) {
            // Map<String, String> map = values[i];
            //  _postList.add(Post.fromJson(map));
            debugPrint('Id-------${key.toString()}');
          });
        }
        //  return _postList;
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    } catch (ex) {
      print(ex.toString());
    }
  }
}
