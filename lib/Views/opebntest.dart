import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openvpn/flutter_openvpn.dart';
import 'package:get/get.dart';

import 'Opnvpn.dart';

class OVPNPage extends StatefulWidget {
  static Future<void> initPlatformState() async {
    var contennt = await rootBundle.loadString('assets/1.ovpn');

    await FlutterOpenvpn.lunchVpn(
      contennt,
      (isProfileLoaded) {
        print('isProfileLoaded : $isProfileLoaded');
        // Get.defaultDialog(
        //   title: "Profile Connected",
        //   content: Text(isProfileLoaded.toString()),
        // );
      },
      (vpnActivated) {
        print('vpnActivated : $vpnActivated');
        Get.defaultDialog(
            title: "Vpn Connected Connected",
            content: Text(vpnActivated.toString()));
      },
      user: 'pkalos@gmail.com1',
      pass: 'iQtU0U(3aQ[00d',
      onConnectionStatusChanged:
          (duration, lastPacketRecieve, byteIn, byteOut) => print(byteIn),
      expireAt: DateTime.now().add(
        Duration(
          seconds: 180,
        ),
      ),
    );
  }

  @override
  _OVPNPageState createState() => _OVPNPageState();
}

class _OVPNPageState extends State<OVPNPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => NewPAge(
              settings.name.contains(NewPAge.subPath)
                  ? settings.name.split(NewPAge.subPath)[1]
                  : '0',
              settings.name.split(NewPAge.subPath)[1].compareTo('2') < 0),
          settings: settings),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: NewPAge('0', true),
      ),
    );
  }
}
