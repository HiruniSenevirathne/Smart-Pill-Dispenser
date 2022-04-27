import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
import 'package:Smart_Pill_Dispenser_App/components/deleteButton.dart';
import 'package:Smart_Pill_Dispenser_App/components/getImageBuilder.dart';
import 'package:Smart_Pill_Dispenser_App/components/homeButton.dart';
import 'package:Smart_Pill_Dispenser_App/components/scheduleCard.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebase_utils.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerAddScheduleItem.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerHomeScreen.dart';
import 'package:Smart_Pill_Dispenser_App/screens/patient/addCaretaker.dart';
import 'package:Smart_Pill_Dispenser_App/screens/patient/patientCaretakers.dart';
import 'package:Smart_Pill_Dispenser_App/screens/patient/patientSchedule.dart';
import 'package:Smart_Pill_Dispenser_App/screens/patient/patientViewRecords.dart';
import 'package:Smart_Pill_Dispenser_App/screens/userProfileScreen.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart'
    as UserProfileInfo;
import 'package:simple_moment/simple_moment.dart';

import '../LoginScreen.dart';
import '../starterScreen.dart';
import 'package:intl/intl.dart';

class PatientHomeScreen extends StatefulWidget {
  final scheduleId;
  // final scheduleItem;
  final patientId;
  const PatientHomeScreen({Key? key, this.scheduleId, this.patientId})
      : super(key: key);
  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  ScheduleItem? schedule;
  bool haveSchedule = true;
  List<ScheduleItem> todaySchedules = <ScheduleItem>[];
  List<String> dtStrList = <String>[];
  UserProfileInfo.UserInfo? user;
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    FirebaseUtils.saveFCMToken();
    loadUserInfo();
    // toViewSchedule();
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

  Query userRef = FirebaseRefs.dbRef.child(FirebaseRefs.getMyAccountInfoRef);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: userRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                backgroundColor: ColorThemes.colorWhite,
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: ColorThemes.colorOrange,
                          ),
                          accountName: user != null
                              ? Text(user!.firstName + " " + user!.lastName)
                              : Container(),
                          accountEmail: user != null
                              ? Text(user!.email + " | " + "Patient")
                              : Container(),
                          currentAccountPicture: GetImageBuilder()),
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
                    margin: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              // margin: EdgeInsets.only(left: screenWidth / 13),
                              child: Column(
                            children: <Widget>[
                              haveSchedule == false
                                  ? Container(
                                      margin: EdgeInsets.only(bottom: 30),
                                      child: new Image(
                                          image: AssetImage(
                                              "images/homePage.jpg")))
                                  : Container(
                                      margin: EdgeInsets.only(top: 30),
                                      child: scheduleItemReciever(context),
                                    ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 25),
                                  child: Column(
                                    children: <Widget>[
                                      HomeButton(() {
                                        toAddCaretaker();
                                      }, "Add Caretaker"),
                                      SizedBox(width: 10, height: 10),
                                      HomeButton(() {
                                        toSchedule();
                                      }, "Schedule"),
                                      SizedBox(width: 10, height: 10),
                                      HomeButton(() {
                                        toviewRecords();
                                      }, "Past Medications"),
                                    ],
                                  ))
                            ],
                          ))
                        ])));
          }
          return Container();
        });
  }

  Widget scheduleItemReciever(BuildContext context) {
    DateTime datetime = DateTime.now();
    // String cTime = Moment.now().format("HH:mm");
    String patientId = FirebaseAuth.instance.currentUser!.uid;
    print(["patientID", patientId]);
    Query scheduleRef =
        FirebaseRefs.dbRef.child(FirebaseRefs.getTodaySchedules(patientId));
    return StreamBuilder(
        stream: scheduleRef.onValue,
        builder: (context, AsyncSnapshot dataSnapshot) {
          try {
            if (dataSnapshot.hasData) {
              DatabaseEvent event = dataSnapshot.data;
              if (event.snapshot.exists) {
                Map<dynamic, dynamic> result = event.snapshot.value as Map;

                print("************");

                result.keys.forEach((key) {
                  var element = result[key];
                  print(['element', element, key]);
                  todaySchedules.add(ScheduleItem.fromJson(element, key));
                });

                Moment dt1 = Moment.now();
                Moment dt2 = Moment.now();
                Moment dt3 = Moment.now();

                // dt1 = Moment.parse(cDate.format("HH:mm"));
                dt2 = dt1.subtract(minutes: 5);
                dt3 = dt1.add(minutes: 5);
                DateTime ddt1 = dt2.date;
                DateTime ddt2 = dt3.date;
                print(ddt2);
                print(ddt1);

                todaySchedules.forEach((element) {
                  String ScheduleDate = element.date + " " + element.time;
                  DateTime formattedScheduleDate = DateTime.parse(ScheduleDate);

                  print(ScheduleDate);
                  print(formattedScheduleDate);
                  if (ddt1.millisecondsSinceEpoch <=
                          formattedScheduleDate.millisecondsSinceEpoch &&
                      formattedScheduleDate.millisecondsSinceEpoch <=
                          ddt2.millisecondsSinceEpoch) {
                    print(element.time);
                    schedule = element;
                    print("0k");
                  }
                });
              }
            }
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      toViewSchedule(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorThemes.colorYellw,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      // width: screenWidth / 1.2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 30, top: 30),
                                      child: Text(
                                        schedule!.medicationType,
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: 30, top: 30),
                                    child: Text(
                                      schedule!.time,
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: ColorThemes.colorBlue),
                                    ),
                                  )
                                ]),
                            schedule!.comment != ""
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0,
                                        right: 25.0,
                                        top: 10.0,
                                        bottom: 20.0),
                                    child: Text(
                                      schedule!.comment,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 10,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ))
                                : Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, bottom: 30.0),
                                  ),
                            schedule!.medicationType == "Pills"
                                ? (Container())
                                : Form(
                                    key: _formKey,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 25.0),
                                          child: DefaultButton(() {
                                            setState(() {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                toChangeStatus();
                                              }
                                            });
                                          }, "Done", ColorThemes.colorGreen),
                                        ),
                                        Container(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 25.0),
                                          child: DeleteButton(() {
                                            setState(() {
                                              toChangeStatus();
                                              // if (_formKey.currentState!.validate()) {
                                              //   // toAddSchedule(context);
                                              //   // toAddSchedule();
                                              // }
                                            });
                                          }, "Fogot", ColorThemes.colorRed),
                                        ),
                                      ],
                                    ),
                                  ),
                          ]),
                    ),
                  ),
                ),
              ],
            );
          } catch (err) {
            print(err);
            return Text("Error");
          }
        });
  }

  void toViewSchedule(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CaretakerAddScheduleItemScreen(
                patientId: widget.patientId,
                scheduleId: widget.scheduleId,
                isEdit: true,
              )),
    );
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
      Fluttertoast.showToast(
          msg: "Changed the Mode Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Can\'t Change the Mode!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    print('logged as caretaker');
    print('read: $value');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
    );
  }

  void toAddCaretaker() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PatientCaretakers()),
    );
  }

  void toSchedule() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PatientScheduleScreen()),
    );
  }

  void toviewRecords() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PatientViewRecords()),
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

  void toChangeStatus() async {
    try {
      String patientId = FirebaseAuth.instance.currentUser!.uid;
      print(["schedule", schedule!.scheduleId]);
      print(["patient", patientId]);
      await FirebaseRefs.dbRef
          .child(
              FirebaseRefs.getScheduleItemRef(patientId, schedule!.scheduleId))
          .update({
        'status': "1",
      });
      print("schedule item updated");
    } catch (err) {
      print(err);
    }
  }

  // void toViewSchedule() async {
  //   try {
  //     DateTime datetime = DateTime.now();
  //     // String cTime = Moment.now().format("HH:mm");
  //     String patientId = FirebaseAuth.instance.currentUser!.uid;
  //     print(["patientID", patientId]);
  //     Query scheduleRef =
  //         FirebaseRefs.dbRef.child(FirebaseRefs.getTodaySchedules(patientId));
  //     DataSnapshot event = await scheduleRef.get();
  //     Map<dynamic, dynamic> result = event.value as Map;
  //     print("************");
  //     // print(result.values.first["time"]);
  //     result.keys.forEach((key) {
  //       var element = result[key];
  //       print(['element', element, key]);
  //       todaySchedules.add(ScheduleItem.fromJson(element, key));
  //     });

  //     Moment dt1 = Moment.now();
  //     Moment dt2 = Moment.now();
  //     Moment dt3 = Moment.now();

  //     // dt1 = Moment.parse(cDate.format("HH:mm"));
  //     dt2 = dt1.subtract(minutes: 5);
  //     dt3 = dt1.add(minutes: 5);
  //     DateTime ddt1 = dt2.date;
  //     DateTime ddt2 = dt3.date;
  //     print(ddt2);
  //     print(ddt1);

  //     todaySchedules.forEach((element) {
  //       String ScheduleDate = element.date + " " + element.time;
  //       DateTime formattedScheduleDate = DateTime.parse(ScheduleDate);

  //       print(ScheduleDate);
  //       print(formattedScheduleDate);
  //       if (ddt1.millisecondsSinceEpoch <=
  //               formattedScheduleDate.millisecondsSinceEpoch &&
  //           formattedScheduleDate.millisecondsSinceEpoch <=
  //               ddt2.millisecondsSinceEpoch) {
  //         print("0k");
  //       }
  //     });
  //   } catch (e) {
  //     print("***************error");
  //   }
  // }
}
