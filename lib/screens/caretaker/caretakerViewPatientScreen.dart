import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';

import 'caretakerPatientListScreen.dart';
import 'caretakerViewScheduleScreen.dart';
import 'package:flutter/material.dart';

class CaretakerViewPatientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CaretakerViewPatientScreenState();
  }
}

class CaretakerViewPatientScreenState
    extends State<CaretakerViewPatientScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Pill Dispenser'),
          backgroundColor: ColorThemes.appbarColor,
        ),
        body: Container(
            margin: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: screenHeight / 22),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Patient\'s Profile',
                            style: TextStyle(fontSize: 40, color: Colors.black),
                          ),
                          SizedBox(width: 10, height: 5),
                          Container(
                              margin: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 10.0,
                                      left: screenWidth / 8,
                                    ),
                                    child: SizedBox(
                                      width: 200.0,
                                      height: 200.0,
                                      child: getImageAsset(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Text(
                                      'Patient\'s Name',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 2.0, bottom: 10.0),
                                    child: Text(
                                      'Hiruni Senevirathne',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 25.0, bottom: 10.0),
                                    child: Text(
                                      'Patient\'s Age',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 2.0, bottom: 10.0),
                                    child: Text(
                                      '24',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                  Column(children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5.0, bottom: 5.0),
                                      child: new MaterialButton(
                                          height: 55.0,
                                          minWidth: 200.0,
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              left: 15,
                                              right: 15),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: ColorThemes.customButtonColor,
                                          textColor: Colors.white,
                                          child: Text(
                                            'View Schedule',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          onPressed: () {
                                            toSchedule(context);
                                          }),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5.0, bottom: 10.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new MaterialButton(
                                                height: 55.0,
                                                minWidth: 120.0,
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 12,
                                                    right: 12),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                color: ColorThemes
                                                    .customButtonColor,
                                                textColor: Colors.white,
                                                child: Text(
                                                  'Edit',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                onPressed: () {
                                                  //
                                                }),
                                            SizedBox(width: 5, height: 5),
                                            new MaterialButton(
                                                height: 55.0,
                                                minWidth: 120.0,
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 12,
                                                    right: 12),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                color: ColorThemes
                                                    .deleteButtonColor,
                                                textColor: Colors.white,
                                                child: Text(
                                                  'Delete',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                onPressed: () {
                                                  toDelete(context);
                                                }),
                                          ]),
                                    ),
                                  ])
                                ],
                              ))
                        ])),
              ],
            )));
  }

  void toSchedule(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CaretakerViewScheduleScreen()),
    );
  }

  void toDelete(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CaretakerPatientListScreen()),
    );
  }
}

Widget getImageAsset() {
  AssetImage assetImage = AssetImage('images/avater.jpg');
  Image image = Image(
    image: assetImage,
  );
  return Container(
    child: image,
  );
}
