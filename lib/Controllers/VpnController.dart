import 'package:flutter/services.dart';
import 'package:flutter_openvpn/flutter_openvpn.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MSVpnController extends GetxController {
  RxString isConneString = 'Connect'.obs;
  //TODO
  RxBool isConnected = false.obs;
  RxString userEmail = ''.obs;
  RxString pass = ''.obs;
  RxDouble connectLoad = 1.0.obs;
  RxString selectedContry = 'Canada'.obs;
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future connectVpn(String _email, String _pass) async {
    if (isConnected.value == false) {
      FlutterOpenvpn.init(
        localizedDescription: "MacSentry",
        providerBundleIdentifier: "com.engra.macsentry",
      ).then((value) {
        print(value);
      });
      connectLoad.value = 0.5;
      await initPlatformState(_email, _pass);
    }

    connectLoad.value = 1.0;
  }

  Future disconnectVpn() async {
    isConneString.value = 'Disconnecting';
    // connectLoad.value = 0.5;
    if (isConnected.value == true) {
      await FlutterOpenvpn.stopVPN().then((value) {
        // connectLoad.value = 1.0;
      });
    }
  }

  Future<void> initPlatformState(String email, String password) async {
    var contennt = await rootBundle.loadString('assets/1.ovpn');
    await saveCred(email, password);
    await FlutterOpenvpn.lunchVpn(contennt, (isProfileLoaded) {
      print('isProfileLoaded : $isProfileLoaded');
      //connectLoad.value = 0.5;
      // Get.defaultDialog(
      //   title: "Profile Connected",
      //   content: Text(isProfileLoaded.toString()),
      // );
    }, (vpnActivated) {
      print('vpnActivated : $vpnActivated');
      if (vpnActivated == 'DISCONNECTED') {
        isConneString.value = 'Connect';
        if (connectLoad.value != 1.0) connectLoad.value = 1.0;
        isConnected.value = false;
      } else if (vpnActivated == 'CONNECTED') {
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

  @override
  void onClose() {
    FlutterOpenvpn.stopVPN();
    // TODO: implement onClose
    super.onClose();
  }
}
