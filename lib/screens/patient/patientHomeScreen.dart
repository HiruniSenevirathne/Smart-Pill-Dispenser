import 'package:Smart_Pill_Dispenser_App/components/homeButton.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerHomeScreen.dart';
import 'package:Smart_Pill_Dispenser_App/screens/patient/addCaretaker.dart';
import 'package:Smart_Pill_Dispenser_App/screens/patient/patientSchedule.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LoginScreen.dart';
import '../starterScreen.dart';

class PatientHomeScreen extends StatefulWidget {
  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

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
              ListTile(
                title: const Text('Change Mode'),
                onTap: () {
                  changeMode();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Smart Pill Dispenser'),
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
            margin:
                EdgeInsets.only(left: 25.0, right: 25.0, top: screenHeight / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        HomeButton(() {
                          toAddCaretaker();
                        }, "Add Caretaker"),
                        SizedBox(width: 10, height: 10),
                        HomeButton(() {
                          //
                        }, "Schedule"),
                        SizedBox(width: 10, height: 10),
                        HomeButton(() {
                          // toPastMedications(context);
                        }, "Past Medications"),
                      ],
                    ))
              ],
            )));
  }

  void changeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'mode';
    final value = EnumToString.convertToString(Mode.caretaker);
    prefs.setString(key, value);
    try {
      FirebaseRefs.dbRef.child(FirebaseRefs.getMyAccountInfoRef).update({
        'mode': value,
      });
      FirebaseRefs.dbRef.child(FirebaseRefs.getPatientInfoRef).update({
        'caretakerId': FirebaseAuth.instance.currentUser!.uid,
        'caretakerEmail': FirebaseAuth.instance.currentUser!.email
      });
    } catch (err) {
      print(err);
    }
    print('logged as caretaker');
    print('read: $value');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
    );
  }

  void toAddCaretaker() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddCaretakerScreen()),
    );
  }

  void toSchedule() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PatientScheduleScreen()),
    );
  }

  void userSignout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
