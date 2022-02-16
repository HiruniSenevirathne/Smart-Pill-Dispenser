import 'package:Smart_Pill_Dispenser_App/components/getImageAsset.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart'
    as UserProfileInfo;
import 'package:Smart_Pill_Dispenser_App/modules/patient.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerHomeScreen.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  UserProfileInfo.UserInfo? user;
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
      user = UserProfileInfo.UserInfo.fromJson(result);
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
                      margin: EdgeInsets.only(left: 20.0, right: 10.0, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.0,
                              left: screenWidth / 8,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: SizedBox(
                                child: toGetPatientImage(),
                              ),
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 15.0),
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
                                        top: 23.0, bottom: 15.0),
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
                                        top: 23.0, bottom: 15.0, left: 15),
                                    child: user?.mode == null
                                        ? CircularProgressIndicator()
                                        : Text(
                                            user!.firstName +
                                                " " +
                                                user!.lastName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 10,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
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
                              padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // new MaterialButton(
                                    //     height: 55.0,
                                    //     minWidth: 120.0,
                                    //     padding: EdgeInsets.only(
                                    //         top: 10,
                                    //         bottom: 10,
                                    //         left: 12,
                                    //         right: 12),
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(20)),
                                    //     color: ColorThemes.colorGreen,
                                    //     textColor: Colors.white,
                                    //     child: Text(
                                    //       'Edit',
                                    //       style: TextStyle(fontSize: 15),
                                    //     ),
                                    //     onPressed: () {
                                    //       //
                                    //     }),

                                    new MaterialButton(
                                        height: 55.0,
                                        minWidth: 150.0,
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 15,
                                            right: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        color: ColorThemes.colorGreen,
                                        textColor: Colors.white,
                                        child: Text(
                                          'View Schedule',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () {
                                          toSchedule(context);
                                        }),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    new MaterialButton(
                                        height: 55.0,
                                        minWidth: 150.0,
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 12,
                                            right: 12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        child: Text(
                                          'Leave Patient',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () {
                                          leavePatient(context);
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

  void leavePatient(BuildContext context) async {
    try {
      await FirebaseRefs.dbRef
          .child(FirebaseRefs.getSpecificCaretakerPatientsRef(
              FirebaseAuth.instance.currentUser!.uid, widget.patientId))
          .remove();
      await FirebaseRefs.dbRef
          .child(FirebaseRefs.getSpecificCaretakerRef(
              FirebaseAuth.instance.currentUser!.uid, widget.patientId))
          .remove();
      Fluttertoast.showToast(
          msg: "Removed the Patient Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.of(context).pop(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
      );
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Can't Remove the Patient!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget toGetPatientImage() {
    toGetImage() async {
      String imgeDbRef =
          FirebaseRefs.getPatientAccountImageIdRef(widget.patientId);
      // print(widget.patient!.patientName);
      Query imageRef = FirebaseRefs.dbRef.child(imgeDbRef);
      print(imgeDbRef);
      DataSnapshot event = await imageRef.get();
      print(event.value);
      final ref = FirebaseStorage.instance.ref().child(event.value.toString());
      var url = await ref.getDownloadURL();
      print(url);
      return url;
    }

    return FutureBuilder<String>(
        future: toGetImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());
            return Container(
              child: CachedNetworkImage(
                imageUrl: snapshot.data.toString(),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 90,
                ),
              ),
            );
          }
          return GetImageAsset();
        });
  }
}
