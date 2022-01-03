import 'dart:async';

import 'package:Smart_Pill_Dispenser_App/caretakerHomeScreen.dart';
import 'package:Smart_Pill_Dispenser_App/caretakerLoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';

class StarterScreen extends StatefulWidget {
  @override
  State<StarterScreen> createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {
  late StreamSubscription userAthSub;
  @override
  void initState() {
    userAthSub = FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CaretakerLoginScreen()),
        );
      } else {
        print('User is signed in!');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
        );
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
                            color: Color(0xff512DA8),
                            textColor: Colors.white,
                            child: Text('Caretaker'),
                            onPressed: () {
                              //
                            }),
                        SizedBox(width: 10, height: 10),
                        new MaterialButton(
                            height: 40.0,
                            minWidth: 337.0,
                            padding: EdgeInsets.only(
                                top: 30, bottom: 30, left: 60, right: 60),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Color(0xff512DA8),
                            textColor: Colors.white,
                            child: Text('Patient'),
                            onPressed: () {
                              //
                            }),
                      ],
                    ))
              ],
            )));
  }
}
