import 'dart:async';
import 'package:Smart_Pill_Dispenser_App/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'caretaker/caretakerHomeScreen.dart';
import 'patient/patientHomeScreen.dart';
import 'starterScreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late StreamSubscription userAthSub;
  String mode = '';
  @override
  void initState() {
    userAthSub = FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        print('User is signed in!');
        getMode();
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
        // );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (userAthSub != null) {
      userAthSub.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(left: 15.0, right: 10.0, bottom: 94.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 100,
                ),
                Text('Welcome to Smart pill dispenser',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.left),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.left),
              ],
            )));
  }

  void getMode() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'mode';
    final value = prefs.getString(key) ?? 'patient';
    print('read: $value');
    if (value == 'caretaker') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
      );
      print('logged as caretaker');
    } else if (value == 'patient' || value == '') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PatientHomeScreen()),
      );
      print('logged as patient');
    }
  }
}
