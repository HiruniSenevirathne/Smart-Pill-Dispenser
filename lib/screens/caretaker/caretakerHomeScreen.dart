import 'package:Smart_Pill_Dispenser_App/components/getImageBuilder.dart';
import 'package:Smart_Pill_Dispenser_App/components/patientCard.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebase_utils.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart'
    as UserProfileInfo;
import 'package:Smart_Pill_Dispenser_App/screens/patient/patientHomeScreen.dart';
import 'package:Smart_Pill_Dispenser_App/screens/starterScreen.dart';
import 'package:Smart_Pill_Dispenser_App/screens/userProfileScreen.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginScreen.dart';
import 'caretakerPatientListScreen.dart';

class CaretakerHomeScreen extends StatefulWidget {
  @override
  State<CaretakerHomeScreen> createState() => _CaretakerHomeScreenState();
}

class _CaretakerHomeScreenState extends State<CaretakerHomeScreen> {
  String mode = '';
  UserProfileInfo.UserInfo? user;
  @override
  void initState() {
    super.initState();
    FirebaseUtils.saveFCMToken();
    loadUserInfo();
  }

  void loadUserInfo() async {
    try {
      String ref = FirebaseRefs.getMyAccountInfoRef;
      Query userRef = FirebaseRefs.dbRef.child(ref);

      DataSnapshot event = await userRef.get();
      Map<dynamic, dynamic> result = event.value as Map;
      print("------------------------");
      print(result);
      user = UserProfileInfo.UserInfo.fromJson(result);
      // print(user!.firstName);
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  Query patientsRef =
      FirebaseRefs.dbRef.child(FirebaseRefs.getCaretakerPatientsRef);
  Query userRef = FirebaseRefs.dbRef.child(FirebaseRefs.getMyAccountInfoRef);
  Widget build(BuildContext context) {
    var patientWidgets = [];
    patientIds.forEach((patientId) {
      patientWidgets.add(PatientCard(patientId: patientId));
      patientWidgets.add(Divider(color: Colors.black));
    });
    return StreamBuilder<Object>(
        stream: userRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: ColorThemes.colorWhite,
              drawer: Drawer(
                backgroundColor: ColorThemes.colorWhite,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: ColorThemes.colorOrange,
                      ),
                      accountName: user?.mode == null
                          ? LinearProgressIndicator()
                          : user != null
                              ? Text(user!.firstName + " " + user!.lastName)
                              : Container(),
                      accountEmail: user != null
                          ? Text(
                              user!.email + " | " + "Caretaker",
                            )
                          : Container(),
                      currentAccountPicture: GetImageBuilder(),
                    ),
                    ListTile(
                      title: const Text('User Profile'),
                      onTap: () {
                        userProfile(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Change Mode'),
                      onTap: () {
                        changeMode();
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
                title: Text('Patient List'),
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
                  right: 25.0,
                ),
                child: StreamBuilder<Object>(
                    stream: patientsRef.onValue,
                    builder: (context, AsyncSnapshot dataSnapshot) {
                      print(["Info", dataSnapshot.data]);

                      if (!dataSnapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        DatabaseEvent event = dataSnapshot.data;

                        List<Widget> patientWidgets = [];
                        if (event.snapshot.exists) {
                          Map<dynamic, dynamic> result =
                              event.snapshot.value as Map;

                          result.keys.forEach((element) {
                            patientWidgets.add(PatientCard(
                                key: Key("${element}"), patientId: element));
                            patientWidgets.add(Divider(color: Colors.black));
                          });
                        }
                        return ListView(children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[...patientWidgets]))
                        ]);
                      }
                    }),
              ),
            );
          }
          return Container();
        });
  }

  void toPatients(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CaretakerPatientListScreen()),
    );
  }

  // void toPastMedications(BuildContext context) {
  void changeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'mode';
    final value = EnumToString.convertToString(Mode.patient);
    print("ENUM TO STRING AUTH MODE:" + value);
    prefs.setString(key, value);
    try {
      FirebaseRefs.dbRef.child(FirebaseRefs.getMyAccountInfoRef).update({
        'mode': value,
      });
      FirebaseRefs.dbRef.child(FirebaseRefs.getPatientInfoRef).update({
        'patient_id': FirebaseAuth.instance.currentUser!.uid,
        'patient_email': FirebaseAuth.instance.currentUser!.email
      });
      Fluttertoast.showToast(
          msg: "Successfully Changed the mode",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Changing the Mode is not Successful!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    print('logged as patient');
    print('read: $value');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => PatientHomeScreen()),
    );
  }

  void userSignout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void userProfile(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => UserProfileScreen(
              userId: FirebaseAuth.instance.currentUser!.uid)),
    );
  }

  List<String> patientIds = <String>[];

  void getPatientList() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      Query patientsRef =
          FirebaseRefs.dbRef.child(FirebaseRefs.getCaretakerPatientsRef);

      DataSnapshot event = await patientsRef.get();
      Map<dynamic, dynamic> result = event.value as Map;
      print(result.keys);
      patientIds.clear();
      result.keys.forEach((element) {
        patientIds.add(element);
      });
      setState(() {});
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "No Patients\' Information!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
