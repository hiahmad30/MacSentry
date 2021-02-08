import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          child: GestureDetector(
            onTap: () {
              print('clicky');
            },
            child: ClipOval(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
//        [Your content here]
      ],
    ));
  }
}
