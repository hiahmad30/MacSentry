import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flag/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openvpn/flutter_openvpn.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:macsentry/Models/ServerListModel.dart';

class MSVpnController extends GetxController {
  RxString isConneString = 'Connect'.obs;
  //TODO
  RxBool isConnected = false.obs;

  RxDouble connectLoad = 0.0.obs;
  RxString selectedContry = ''.obs;
  Rx<ServerListModel> selectedServer =
      ServerListModel('Dubai', 'dxb01.macsentry.com', null, '').obs;
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //

  @override
  Future<void> onInit() async {
    await fetchPost();
    //getHttp("email", "pass", "trId");
    super.onInit();
  }

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
      matchfile();
      await initPlatformState(
          _email, _pass, selectedServer.value.file.toString());
    }
  }

  Future disconnectVpn() async {
    isConneString.value = 'Disconnecting';

    if (isConnected.value == true) {
      await FlutterOpenvpn.stopVPN().then((value) {});
    }
  }

  Future<void> initPlatformState(
      String email, String password, String vpnString) async {
    //   await saveCred(email, password);
    var contennt = await rootBundle.loadString('assets/1.ovpn');
    //    (await fetchOVPn(serverListModel.fileUrl))
    //      .toString()); //serverListModel.file);

    try {
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
          // user: email,
          // pass: password,
          user: 'pkalos@gmail.com1',
          pass: 'iQtU0U(3aQ[00d',
          onConnectionStatusChanged:
              (duration, lastPacketRecieve, byteIn, byteOut) => print(byteIn),
          expireAt: DateTime.now().add(
            Duration(
              minutes: 60,
            ),
          ));
    } catch (ex) {
      print('$ex');
      isConneString.value = 'Connect';
    }
  }

  /////////////////////////////////sAVE DATA
  matchfile() {
    if (selectedContry.value != '') {
      serverList.forEach((element) {
        if (element.country == selectedContry.value) {
          selectedServer.value = element;
        }
      });
    }
  }

  Future<Map> getHttp(String email, String pass, String trId) async {
    try {
      final response = await Dio().post(
          "https://macsentry.com/appstore/create.php",
          data: {'email': email, 'password': pass, 'transactionId': trId});
      if (response.statusMessage == 'OK') {
        final Map parsed = json.decode(response.data.toString());

        print(parsed);

        //  saveCred(parsed['user'], parsed['password']);
        return parsed;
      } else {
        Get.defaultDialog(
            title: 'Server Error',
            content: Text(response.statusMessage.toString()));
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void onClose() {
    FlutterOpenvpn.stopVPN();
    // TODO: implement onClose
    super.onClose();
  } ////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
  List<ServerListModel> serverList = [];
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

  Future<void> fetchPost() async {
    try {
      final response = await http
          .get(Uri.https('www.macsentry.com', '/config/serverList.php'));

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        Map<String, dynamic> values = json.decode(response.body);
        if (values != null) {
          int count = 0;
          values.forEach((key, value) async {
            File ofile = await fetchOVPn(values[key]);
            serverList
                .add(ServerListModel(key, values[key], ofile, values[key]));

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
                            serverList[count].country.toString().substring(
                                serverList[count].country.toString().length - 2,
                                serverList[count].country.toString().length),
                            fit: BoxFit.cover,
                            height: 30,
                            width: 30,
                            replacement: Icon(Icons.flag_outlined),
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
          // serverList.forEach((element) {});
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load dropdown');
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  static var httpClient = new HttpClient();

  Future<File> fetchOVPn(String serverurl) async {
    try {
      var request = await httpClient
          .getUrl(Uri.parse('https://macsentry.com/config/$serverurl.ovpn'));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      File ovpnFile = File.fromRawPath(bytes);
      // print('File Fetched=>...........${ovpnFile.toString()}');
      return ovpnFile;
    } catch (e) {
      print('File Fetching Error=>.................${e.toString()}');
      return null;
    }
  }
}
