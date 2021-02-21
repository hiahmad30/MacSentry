import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openvpn/flutter_openvpn.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MSVpnController extends GetxController {
  RxString isConneString = 'Connect'.obs;
  //TODO
  RxBool isConnected = false.obs;
  RxDouble connectLoad = 0.0.obs;
  RxString selectedContry = 'Canada'.obs;
  Future connectVpn() async {
    isConneString.value = 'CONNECTING';
    if (isConnected.value == false) {
      FlutterOpenvpn.init(
        localizedDescription: "MacSentry",
        providerBundleIdentifier: "com.engra.macsentry",
      ).then((value) {
        print(value);
      });
      connectLoad.value = 0.5;
      await initPlatformState();
    }

    connectLoad.value = 1.0;
  }

  Future disconnectVpn() async {
    isConneString.value = 'DISCONNECTING';
    connectLoad.value = 0.5;
    if (isConnected.value == true) {
      await FlutterOpenvpn.stopVPN().then((value) {
        connectLoad.value = 1.0;
        isConneString.value = 'CONNECT';
      });
    }
  }

  Future<void> initPlatformState() async {
    var contennt = await rootBundle.loadString('assets/1.ovpn');
    await FlutterOpenvpn.lunchVpn(contennt, (isProfileLoaded) {
      print('isProfileLoaded : $isProfileLoaded');
      connectLoad.value = 0.5;
      // Get.defaultDialog(
      //   title: "Profile Connected",
      //   content: Text(isProfileLoaded.toString()),
      // );
    }, (vpnActivated) {
      print('vpnActivated : $vpnActivated');
      if (vpnActivated == 'DISCONNECTED') {
        isConneString.value = 'DISCONNECTED';
        if (connectLoad.value != 1.0) connectLoad.value = 1.0;
        isConnected.value = false;
      } else if (vpnActivated == 'CONNECTED') {
        isConnected.value = true;
        isConneString.value = 'CONNECTED';
      }
    },
        user: 'pkalos@gmail.com1',
        pass: 'iQtU0U(3aQ[00d',
        onConnectionStatusChanged:
            (duration, lastPacketRecieve, byteIn, byteOut) => print(byteIn),
        expireAt: DateTime.now().add(
          Duration(
            minutes: 1,
          ),
        ));
  }

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
        List<Map<String, dynamic>> values = new List<Map<String, dynamic>>();
        values = json.decode(response.body);
        if (values.length > 0) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, String> map = values[i];
              //  _postList.add(Post.fromJson(map));
              debugPrint('Id-------${map.toString()}');
            }
          }
        }
        return _postList;
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    } catch (ex) {
      print(ex.toString());
    }
  }
}
