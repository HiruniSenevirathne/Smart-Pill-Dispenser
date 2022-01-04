import 'package:flutter/material.dart';

class PatientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Pill Dispenser'),
          backgroundColor: Color(0xff140078),
        ),
        body: Container(
            margin:
                EdgeInsets.only(left: 25.0, right: 25.0, top: screenHeight / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        new MaterialButton(
                            height: 112.0,
                            minWidth: 337.0,
                            padding: EdgeInsets.only(
                                top: 30, bottom: 30, left: 40, right: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Color(0xff512DA8),
                            textColor: Colors.white,
                            child: Text(
                              'Schedule',
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () {
                              //
                            }),
                        SizedBox(width: 10, height: 10),
                        new MaterialButton(
                            height: 112.0,
                            minWidth: 337.0,
                            padding: EdgeInsets.only(
                                top: 30, bottom: 30, left: 40, right: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Color(0xff512DA8),
                            textColor: Colors.white,
                            child: Text(
                              'Past Medications',
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () {
                              //
                            }),
                      ],
                    ))
              ],
            )));
  }
}
