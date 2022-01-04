import 'caretakerEditSchedule.dart';
import 'package:flutter/material.dart';

import 'caretakerAddSchedule.dart';

class CaretakerViewScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CaretakerViewScheduleScreenState();
  }
}

class CaretakerViewScheduleScreenState
    extends State<CaretakerViewScheduleScreen> {
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
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 60.0, left: 20, right: 20),
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                        width: screenWidth / 2.4, height: 45),
                                    Padding(
                                        padding: EdgeInsets.only(top: 60),
                                        child: SizedBox(
                                            width: 45.0,
                                            height: 45.0,
                                            child: new FloatingActionButton(
                                                child: new Icon(
                                                  Icons.add,
                                                  size: 35,
                                                  color: Colors.black,
                                                ),
                                                backgroundColor:
                                                    new Color(0xFFffffff),
                                                onPressed: () {
                                                  toAddSchedule(context);
                                                }))),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 30.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          toViewSchedule(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          decoration: BoxDecoration(
                                            color: Color(0Xffffffff),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          height: 100,
                                          width: screenWidth / 1.35,
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0),
                                                    child: (Text(
                                                      '09.00',
                                                      style: TextStyle(
                                                          fontSize: 30),
                                                    ))),
                                                SizedBox(width: 50, height: 5),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20.0),
                                                          child: (Text(
                                                            'Pills',
                                                            style: TextStyle(
                                                                fontSize: 25),
                                                          ))),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20.0),
                                                          child: (Text(
                                                            'Comments',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )))
                                                    ])
                                              ]),
                                        ))),
                              ]),
                        ))
                  ]),
            )
          ],
        )));
  }

  void toAddSchedule(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CaretakerAddScheduleScreen()),
    );
  }

  void toViewSchedule(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CaretakerEditScheduleScreen()),
    );
  }
}
