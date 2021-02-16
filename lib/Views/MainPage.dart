import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macsentry/Controllers/VpnController.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants.dart';
import 'ButtonWidget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final vpnController = Get.put(MSVpnController());
  ///////////////////////////////////////////////

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
                child: Obx(
                  () => vpnController.isConnected.value
                      ? Container(
                          padding: EdgeInsets.all(25.0),
                          child: CircularPercentIndicator(
                            progressColor: vpnController.isConnected.value
                                ? MyResources.loginBtnColor
                                : Colors.red,
                            percent: vpnController.connectLoad.value,
                            animateFromLastPercent: true,
                            animationDuration: 200,
                            animation: true,
                            radius: 220.0,
                            lineWidth: 15.0,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  vpnController.isConnected.value
                                      ? Container()
                                      : Text(
                                          'Tap to',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                  Text(vpnController.isConneString.value,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: vpnController.isConnected.value
                                            ? Colors.red
                                            : MyResources.loginBtnColor,
                                      )),
                                ],
                              ),
                              radius: 100,
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            child: Stack(children: [
                              Container(
                                  child: Image.asset('assets/connected.png')),
                              Positioned(
                                child: Text(
                                  'Bhai',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ]),
                          ),
                        ),
                ),
                onTap: () async {
                  await vpnController.connectVpn();
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 60),
                child: Obx(
                  () => Container(
                    color: Colors.white,
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      underline: Text(""),
                      value: vpnController.selectedContry.value,
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
                                    child: Text('Canada'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          value: 'Canada',
                        ),
                      ],
                      onChanged: (String value) {
                        print(value);
                        setState(() {
                          vpnController.selectedContry.value = value;
                        });
                      },
                      hint: Text('Select Item'),
                    ),
                  ),
                ),
              )
            ],
          )),
          //    [Your content here]
          Positioned(
            bottom: 0.0,
            child: Container(
              width: Get.width,
              color: Colors.white.withOpacity(0.8),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        'assets/disconnected.png',
                        width: 68,
                        height: 68,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Not Connected',
                          style: GoogleFonts.montserrat(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: Get.width * 0.7,
                          child: Text(
                            'Your Internet connection is not secure, Your data is not encrypted.',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
