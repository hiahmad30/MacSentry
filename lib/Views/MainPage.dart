import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macsentry/Controllers/AuthController.dart';
import 'package:macsentry/Controllers/VpnController.dart';
import 'package:macsentry/Models/ServerListModel.dart';
import 'package:macsentry/Views/Login.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final vpnController = Get.put(MSVpnController());
  final authController = Get.put(AuthController());
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
                child: Obx(() => vpnController.isConnected.value
                    ? Center(
                        child: Container(
                          child: Stack(
                              alignment: AlignmentDirectional.centerStart,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/connected.png',
                                      width: 200,
                                      height: 200,
                                    )),
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Tap to',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Disconnect',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(25.0),
                        child: CircularPercentIndicator(
                          progressColor: //vpnController .isConnected.value                              ?
                              MyResources.loginBtnColor,
                          //  : Colors.red,
                          percent: vpnController.connectLoad.value,
                          animateFromLastPercent: true,
                          animationDuration: 1000,
                          animation: true,
                          radius: 180.0,
                          lineWidth: 15.0,
                          circularStrokeCap: CircularStrokeCap.square,
                          center: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                vpnController.isConnected.value
                                    ? Container()
                                    : vpnController.isConneString.value ==
                                            'Connecting'
                                        ? Container()
                                        : Text(
                                            'Tap to',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                Text(vpnController.isConneString.value,
                                    style: TextStyle(
                                      fontSize: 25,
                                    )),
                              ],
                            ),
                            radius: 80,
                          ),
                        ),
                      )),
                onTap: () async {
                  if (!vpnController.isConnected.value) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (vpnController.selectedContry.value !=
                        '') if (prefs.getString('trId') == null)
                      Get.to(() => LoginPage());
                    else {
                      await authController.checkAlready();
                    }
                    else
                      Get.rawSnackbar(
                          title: 'Country Error',
                          message: 'Please Select Country first');
                  } else
                    vpnController.disconnectVpn();
                  //
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 40),
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
                      items: vpnController.serverDropDownItem
                      //  [
                      //   DropdownMenuItem<String>(
                      //     child: Row(
                      //       children: [
                      //         Row(
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.only(left: 20.0),
                      //               child: Text('Canada'),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //     value: 'Canada',
                      //   ),
                      // ],
                      ,
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
                  child: Obx(
                    () => Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: vpnController.isConnected.value
                              ? Image.asset(
                                  'assets/connectedLock.png',
                                  width: 55,
                                  height: 55,
                                )
                              : Image.asset(
                                  'assets/disconnectedLock.png',
                                  width: 60,
                                  height: 60,
                                ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vpnController.isConnected.value
                                  ? 'Connected'
                                  : 'Not Connected',
                              style: GoogleFonts.montserrat(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: Get.width * 0.7,
                              child: Text(
                                vpnController.isConnected.value
                                    ? 'Your Internet connection secure, and your data & privacy are protected.'
                                    : 'Your Internet connection is not secure, Your data is not encrypted.',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
