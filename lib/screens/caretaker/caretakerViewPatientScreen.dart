import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart';
import 'package:Smart_Pill_Dispenser_App/modules/patient.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';

import 'caretakerViewScheduleScreen.dart';
import 'package:flutter/material.dart';

class CaretakerViewPatientScreen extends StatefulWidget {
  final String patientId;
  final Patients? patient;

  const CaretakerViewPatientScreen(
      {Key? key, required this.patientId, this.patient})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CaretakerViewPatientScreenState();
  }
}

class CaretakerViewPatientScreenState
    extends State<CaretakerViewPatientScreen> {
  UserInfo? user;
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadPatientInfo();
  }

  void loadPatientInfo() async {
    try {
      String ref = FirebaseRefs.getUserInfoRef(widget.patientId);
      Query patientRef = FirebaseRefs.dbRef.child(ref);

      DataSnapshot event = await patientRef.get();
      Map<dynamic, dynamic> result = event.value as Map;
      print(result);
      user = UserInfo.fromJson(result);
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient\'s Details'),
        backgroundColor: ColorThemes.colorOrange,
        foregroundColor: ColorThemes.colorWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 25.0,
          right: 10.0,
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 50),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text(
                    //   'Patient\'s Profile',
                    //   style: TextStyle(fontSize: 40, color: Colors.black),
                    // ),
                    // SizedBox(width: 10, height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 10.0),
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
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 15.0),
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: ColorThemes.colorBlue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 15.0),
                                    child: Text(
                                      " :",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: ColorThemes.colorBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 15.0, left: 15),
                                    child: Text(
                                      user!.firstName + " " + user!.lastName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 10,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ),
                                )
                              ]),
                          Row(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Last Active',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: ColorThemes.colorBlue,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                " :",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: ColorThemes.colorBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, bottom: 15.0, left: 15),
                                child: Text(
                                  "2 minutes ago",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                          ]),
                          Row(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Device Status',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: ColorThemes.colorBlue),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                " :",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: ColorThemes.colorBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, bottom: 15.0, left: 15),
                                child: Text(
                                  "On",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                          ]),
                          Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 30.0, bottom: 5.0),
                              child: new MaterialButton(
                                  height: 55.0,
                                  minWidth: 200.0,
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 15, right: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: ColorThemes.colorGreen,
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
                              padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                                BorderRadius.circular(20)),
                                        color: ColorThemes.colorGreen,
                                        textColor: Colors.white,
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(fontSize: 15),
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
                                                BorderRadius.circular(20)),
                                        color: ColorThemes.deleteButtonColor,
                                        textColor: Colors.white,
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () {
                                          toDelete(context);
                                        }),
                                  ]),
                            ),
                          ])
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void toSchedule(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              CaretakerViewScheduleScreen(patientId: widget.patientId)),
    );
  }

  void toDelete(BuildContext context) {
    //TODO: delete patient
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
