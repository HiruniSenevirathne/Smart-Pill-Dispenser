import 'package:flutter/material.dart';

class PatientScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PatientScheduleScreenState();
  }
}

class PatientScheduleScreenState extends State<PatientScheduleScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Pill Dispenser'),
          backgroundColor: Color(0xff140078),
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          'Schedule',
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        )),
                    SizedBox(width: 10, height: 40),
                    Container(
                        height: screenHeight,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Color(0Xff512DA8),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(60.0),
                            topLeft: Radius.circular(60.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 60.0),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      decoration: BoxDecoration(
                                        color: Color(0Xffffffff),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      height: 100,
                                      width: screenWidth / 1.28,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.0),
                                                child: (Text(
                                                  '09.00',
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                ))),
                                            SizedBox(width: 50, height: 5),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.0),
                                                      child: (Text(
                                                        'Pills',
                                                        style: TextStyle(
                                                            fontSize: 25),
                                                      ))),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.0),
                                                      child: (Text(
                                                        'Comments',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      )))
                                                ])
                                          ]),
                                    )),
                              ]),
                        ))
                  ]),
            )
          ],
        )));
  }
}
