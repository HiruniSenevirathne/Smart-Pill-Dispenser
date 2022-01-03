import 'package:flutter/material.dart';

class CaretakerPatientPasswordRecivingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Pill Dispenser'),
          backgroundColor: Color(0xff140078),
        ),
        body: Container(
            margin: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            child: ListView(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: screenHeight / 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Register Your Patient',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                      SizedBox(width: 10, height: 35),
                      Container(
                        child: Form(
                          child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Password for the Patient\'s Account',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.0, bottom: 10.0),
                                        child: Text(
                                          'Password ',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0, bottom: 5.0),
                                      child: new MaterialButton(
                                          height: 71.0,
                                          minWidth: 164.0,
                                          padding: EdgeInsets.only(
                                              top: 25,
                                              bottom: 25,
                                              left: 55,
                                              right: 55),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: Color(0xff512DA8),
                                          textColor: Colors.white,
                                          child: Text(
                                            'Done',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          onPressed: () {
                                            //
                                          }),
                                    ),
                                  ])),
                        ),
                      )
                    ],
                  ))
            ])));
  }
}
