import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macsentry/Controllers/VpnController.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants.dart';
import 'ButtonWidget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isConnected;
  final vpnController = Get.put(MSVpnController());
  ///////////////////////////////////////////////
  String selectedContry = 'Dubai';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image(
          image: AssetImage("assets/waves.png"),
          width: Get.width,
          height: Get.height,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 136,
          child: Image(
            image: AssetImage("assets/world.png"),
            width: Get.width,
            // height: Get.height,
            fit: BoxFit.cover,
          ),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                  padding: EdgeInsets.all(25.0),
                  child: Obx(() => CircularPercentIndicator(
                        progressColor: vpnController.isConnected.value
                            ? MyResources.loginBtnColor
                            : Colors.red,
                        percent: vpnController.connectLoad.value,
                        animation: true,
                        radius: 220.0,
                        lineWidth: 15.0,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: CircleAvatar(
                          backgroundColor: Colors.white,
                          child:
                              Obx(() => Text(vpnController.isConneString.value,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: vpnController.isConnected.value
                                        ? MyResources.loginBtnColor
                                        : Colors.red,
                                  ))),
                          radius: 100,
                        ),
                      ))),
              onTap: () async {
                await vpnController.connectVpn();
              },
            ),
            DropdownButton<String>(
              isExpanded: true,
              underline: Text(""),
              value: selectedContry,
              focusColor: Colors.blue,
              elevation: 12,
              items: [
                DropdownMenuItem<String>(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text('Dubai'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  value: 'Dubai',
                ),
                DropdownMenuItem<String>(
                  child: Text('14 Days Free'),
                  value: '14 Days Free',
                ),
              ],
              onChanged: (String value) {
                print(value);
                setState(() {
                  selectedContry = value;
                });
              },
              hint: Text('Select Item'),
            ),
          ],
        )),
        //    [Your content here]
      ],
    ));
  }
}
