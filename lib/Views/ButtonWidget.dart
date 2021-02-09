import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentIndicatorWidget extends StatefulWidget {
  PercentIndicatorWidget({Key key}) : super(key: key);

  @override
  _PercentIndicatorWidgetState createState() => _PercentIndicatorWidgetState();
}

class _PercentIndicatorWidgetState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Percentage Indicator"),
        ),
        body: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: [
                CircularPercentIndicator(
                  progressColor: Colors.redAccent,
                  percent: 0.9,
                  animation: true,
                  radius: 250.0,
                  lineWidth: 15.0,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text("Circle"),
                ),
              ],
            )),
      ),
    );
  }
}
