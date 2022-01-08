import 'dart:async';

import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'caretaker/caretakerHomeScreen.dart';
import 'loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';

import 'patient/patientHomeScreen.dart';

enum Mode { patient, caretaker }

class StarterScreen extends StatefulWidget {
  @override
  State<StarterScreen> createState() => StarterScreenState();
}

class StarterScreenState extends State<StarterScreen> {
  // late StreamSubscription userAthSub;
  // @override
  // void initState() {
  //   userAthSub = FirebaseAuth.instance.userChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');

  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => CaretakerLoginScreen()),
  //       );
  //     } else {
  //       print('User is signed in!');

  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
  //       );
  //     }
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   if (userAthSub != null) {
  //     userAthSub.cancel();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Continue as,',
                  style: TextStyle(fontSize: 40, color: Colors.black),
                ),
                SizedBox(width: 10, height: 20),
                Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        new MaterialButton(
                            height: 40.0,
                            minWidth: 337.0,
                            padding: EdgeInsets.only(
                                top: 30, bottom: 30, left: 60, right: 60),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: ColorThemes.customButtonColor,
                            textColor: Colors.white,
                            child: Text('Caretaker'),
                            onPressed: () {
                              toCaretaker(context);
                            }),
                        SizedBox(width: 10, height: 10),
                        new MaterialButton(
                            height: 40.0,
                            minWidth: 337.0,
                            padding: EdgeInsets.only(
                                top: 30, bottom: 30, left: 60, right: 60),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: ColorThemes.customButtonColor,
                            textColor: Colors.white,
                            child: Text('Patient'),
                            onPressed: () {
                              toPatient(context);
                            }),
                      ],
                    ))
              ],
            )));
  }

  void toCaretaker(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'mode';
    final value = EnumToString.convertToString(Mode.caretaker);
    prefs.setString(key, value);
    try {
      FirebaseRefs.dbRef.child(FirebaseRefs.getUserInfoRef).update({
        'mode': value,
      });
      FirebaseRefs.dbRef.child(FirebaseRefs.getCaretakerInfoRef).set({
        'caretaker_id': FirebaseAuth.instance.currentUser!.uid,
        'caretaker_email': FirebaseAuth.instance.currentUser!.email
      });
    } catch (err) {
      print(err);
    }
    print('logged as caretaker');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
    );
  }

  void toPatient(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'mode';
    final value = EnumToString.convertToString(Mode.patient);
    prefs.setString(key, value);
    try {
      FirebaseRefs.dbRef.child(FirebaseRefs.getUserInfoRef).update({
        'mode': value,
      });
      FirebaseRefs.dbRef.child(FirebaseRefs.getPatientInfoRef).set({
        'patient_id': FirebaseAuth.instance.currentUser!.uid,
        'patient_email': FirebaseAuth.instance.currentUser!.email
      });
    } catch (err) {
      print(err);
    }
    print('logged as patient');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PatientHomeScreen()),
    );
  }
}
