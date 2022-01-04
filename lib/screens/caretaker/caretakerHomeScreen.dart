import 'package:Smart_Pill_Dispenser_App/caretakerLoginScreen.dart';
import 'package:Smart_Pill_Dispenser_App/caretakerPatientListScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CaretakerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Sign out'),
                onTap: () {
                  userSignout(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Smart Pill Dispenser'),
          backgroundColor: Color(0xff140078),
        ),
        body: Container(
            margin:
                EdgeInsets.only(left: 25.0, right: 25.0, top: screenHeight / 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: screenWidth / 13),
                    child: Column(
                      children: <Widget>[
                        new MaterialButton(
                            height: 100.0,
                            minWidth: 300.0,
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 30, right: 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Color(0xff512DA8),
                            textColor: Colors.white,
                            child: Text(
                              'Patients',
                              style: TextStyle(fontSize: 23),
                            ),
                            onPressed: () {
                              toPatients(context);
                            }),
                        SizedBox(width: 10, height: 10),
                        new MaterialButton(
                            height: 100.0,
                            minWidth: 300.0,
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 30, right: 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Color(0xff512DA8),
                            textColor: Colors.white,
                            child: Text(
                              'Past Medications',
                              style: TextStyle(fontSize: 23),
                            ),
                            onPressed: () {
                              // toPastMedications(context);
                            }),
                      ],
                    ))
              ],
            )));
  }

  void toPatients(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CaretakerPatientListScreen()),
    );
  }

  // void toPastMedications(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
  //   );
  // }

  void userSignout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => CaretakerLoginScreen()),
    );
  }
}
