import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macsentry/Controllers/VpnController.dart';
import 'package:macsentry/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyWidgets extends GetxController {
  bool isConnected = false;

  final vpncon = Get.put(MSVpnController);

  Widget buttonWidget() {
    return Container(
        padding: EdgeInsets.all(25.0),
        child: CircularPercentIndicator(
          progressColor: MyResources.loginBtnColor,
          percent: 0.7,
          animation: true,
          radius: 220.0,
          lineWidth: 15.0,
          circularStrokeCap: CircularStrokeCap.round,
          center: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              "Connected",
              style: TextStyle(fontSize: 25),
            ),
            radius: 100,
          ),
        ));
  }
}
