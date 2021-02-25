import 'dart:convert';
import 'dart:io';

import 'package:flag/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openvpn/flutter_openvpn.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:macsentry/Models/ServerListModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MSVpnController extends GetxController {
  RxString isConneString = 'Connect'.obs;
  //TODO
  RxBool isConnected = false.obs;
  RxString userEmail = ''.obs;
  RxString pass = ''.obs;
  RxDouble connectLoad = 0.0.obs;
  RxString selectedContry = ''.obs;
  Rx<ServerListModel> selectedServer =
      ServerListModel('Dubai', 'dxb01.macsentry.com', '').obs;
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future connectVpn(
    String _email,
    String _pass,
  ) async {
    if (isConnected.value == false) {
      FlutterOpenvpn.init(
        localizedDescription: "MacSentry",
        providerBundleIdentifier: "com.engra.macsentry",
      ).then((value) {
        isConneString.value = 'Connecting';
      });
      await initPlatformState(_email, _pass, selectedServer.value);
    }
  }

  Future disconnectVpn() async {
    isConneString.value = 'Disconnecting';

    if (isConnected.value == true) {
      await FlutterOpenvpn.stopVPN().then((value) {});
    }
  }

  Future<void> initPlatformState(
      String email, String password, ServerListModel serverListModel) async {
    await saveCred(email, password);
    var contennt = await rootBundle.loadString(serverListModel.file);

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
  List<ServerListModel> serverList = new List<ServerListModel>();
  RxList<DropdownMenuItem<String>> serverDropDownItem = [
    DropdownMenuItem<String>(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(child: Text('Select a Country')),
        ),
      ),
      value: '',
    )
  ].obs;

  Future<List<dynamic>> fetchPost() async {
    try {
      final response =
          await http.get('https://www.macsentry.com/config/serverList.php');

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        Map<String, dynamic> values = json.decode(response.body);
        if (values != null) {
          int count = 0;
          values.forEach((key, value) async {
            File ofile = await fetchOVPn(values[key]);
            serverList.add(ServerListModel(key, values[key], ofile));
            debugPrint(
                'Countries-------${serverList[count].country.toString()}=>  Urls-------${serverList[count].url.toString()}');
            serverDropDownItem.add(DropdownMenuItem<String>(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                        width: 30,
                        height: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Flag(
                            'Johannesburg',
                            fit: BoxFit.cover,
                            height: 30,
                            width: 30,
                            replacement: Text("not found"),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                          child: Text(serverList[count]
                              .country
                              .toString()
                              .substring(
                                  0,
                                  serverList[count]
                                      .country
                                      .toString()
                                      .indexOf(',')))),
                    ),
                  ],
                ),
              ),
              value: serverList[count].country.toString(),
            ));
            count++;
          });
          serverList.forEach((element) {});
        }
        print('object');
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  static var httpClient = new HttpClient();

  fetchOVPn(String serverurl) async {
    try {
      var request = await httpClient
          .getUrl(Uri.parse('http://macsentry.com/config/$serverurl.ovpn'));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      File ovpnFile = File.fromRawPath(bytes);
      print('File Fetched=>...........${ovpnFile.toString()}');
      return ovpnFile;
    } catch (e) {
      print('File Fetching Error=>.................${e.toString()}');
    }
  }
}
