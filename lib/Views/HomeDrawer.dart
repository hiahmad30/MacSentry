import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macsentry/Controllers/AuthController.dart';
import 'package:macsentry/Views/MainPage.dart';

import '../constants.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool _selected;
  Color dashboardColor = Colors.grey;
  Color eventsColor = Colors.grey;
  Color teamsColor = Colors.grey;
  Color galleryColor = Colors.grey;
  Color announcementColor = Colors.grey;
  String _title = "Dashboard";

  Widget _widget = MainPage();

  final _auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
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
                      "assets/profile.png",
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
                  _title = "Dashboard";
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
              /*  selected: true,*/
              title: Text(
                "Events",
                style: MyResources.myTextStyle,
              ),
              leading: Icon(Icons.event, color: eventsColor),
              onTap: () {
                setState(() {
                  // _widget = EventScreen();
                  _title = "Events";
                  eventsColor = Colors.blue;

                  teamsColor = Colors.grey;
                  dashboardColor = Colors.grey;
                  galleryColor = Colors.grey;
                  announcementColor = Colors.grey;
                });
                Navigator.pop(context);

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => EventScreen()));
              },
            ),
            ListTile(
              dense: true,
              // selected: true,
              title: Text(
                "Teams",
                style: MyResources.myTextStyle,
              ),
              leading: Icon(Icons.group, color: teamsColor),
              onTap: () {
                setState(() {
                  // _widget = TeamsScreen();
                  _title = "Teams";
                  eventsColor = Colors.grey;
                  teamsColor = Colors.blue;
                  announcementColor = Colors.grey;
                  dashboardColor = Colors.grey;
                  galleryColor = Colors.grey;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              title: Text(
                "Reports",
                style: MyResources.myTextStyle,
              ),
              leading: Icon(Icons.receipt_long),
              onTap: () {},
            ),
            ListTile(
              dense: true,
              title: Text(
                "Gallery",
                style: MyResources.myTextStyle,
              ),
              leading: Icon(Icons.image, color: galleryColor),
              onTap: () {
                setState(() {
                  //   _widget = GalleryScreen();
                  _title = "Gallery";
                  galleryColor = Colors.blue;
                  eventsColor = Colors.grey;
                  teamsColor = Colors.grey;
                  announcementColor = Colors.grey;
                  dashboardColor = Colors.grey;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      )),
      body: _widget,
    );
  }
}
