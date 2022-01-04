import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'caretaker/caretakerHomeScreen.dart';
import 'starterScreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late StreamSubscription userAthSub;
  @override
  void initState() {
    userAthSub = FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => StarterScreen()),
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
}
