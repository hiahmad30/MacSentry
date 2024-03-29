import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macsentry/Controllers/AuthController.dart';
import 'package:macsentry/Controllers/VpnController.dart';
import 'package:macsentry/Views/Login.dart';
import 'package:macsentry/Views/MainPage.dart';

import '../constants.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final authController = Get.put(AuthController());
  bool _selected;
  Color dashboardColor = Colors.grey;
  Color eventsColor = Colors.grey;
  Color teamsColor = Colors.grey;
  Color galleryColor = Colors.grey;
  Color announcementColor = Colors.grey;
  String _title = "MacSentry VPN";

  Widget _widget = MainPage();

  final _auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: Container(
            child: Text(
              _title,
              style: GoogleFonts.poppins(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(
            //     Icons.logout,
            //     color: Colors.white,
            //   ),
            //   onPressed: () async {
            //     await _auth.signOut();
            //     // do something
            //   },
            // )
          ],
          //actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
        ),
      ),
      drawer: Drawer(
          child: SingleChildScrollView(
        //height:750,
        // color: Colors.orange,
        child: Column(
          children: <Widget>[
            DrawerHeader(
                child: Column(
              children: [
                InkWell(
                  onTap: () {
                    // Get.to(ProfileEdit());
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "MacSentry",
                      style: MyResources.textStyleprofile,
                    ),
                  ),
                ),
              ],
            )),
            ListTile(
              dense: true,
              // selected: true,
              title: Text(
                "Home",
                style: MyResources.myTextStyle,
              ),
              leading: Icon(Icons.dashboard, color: dashboardColor),
              onTap: () {
                setState(() {
                  //  _widget = DashBoard();
                  _title = "MacSentry VPN";
                  eventsColor = Colors.grey;
                  teamsColor = Colors.grey;
                  galleryColor = Colors.grey;
                  announcementColor = Colors.grey;
                  dashboardColor = Colors.blue;
                });
                Navigator.pop(context);
                //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DashBoard()));
                //(context,
                //  MaterialPageRoute(builder: (context) => DashBoard()));
              },
            ),
            ListTile(
              dense: true,
              title: Text(
                "Logout",
                style: MyResources.myTextStyle,
              ),
              leading: Icon(Icons.image, color: galleryColor),
              onTap: () {
                setState(() {
                  //   _widget = GalleryScreen();
                  _title = "Logout";
                  galleryColor = Colors.blue;
                  eventsColor = Colors.grey;
                  teamsColor = Colors.grey;
                  announcementColor = Colors.grey;
                  dashboardColor = Colors.grey;
                });
                Get.back();
                Get.defaultDialog(
                  title: 'Log out',
                  textConfirm: 'Yes',
                  content: Text('Are you sure to log out?'),
                  onConfirm: () async {
                    await authController.logOutCred();
                    Get.offAll(LoginPage());
                  },
                );
              },
            ),
          ],
        ),
      )),
      body: _widget,
    );
  }
}
