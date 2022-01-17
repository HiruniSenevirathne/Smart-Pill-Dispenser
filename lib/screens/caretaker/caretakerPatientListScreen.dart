import 'package:Smart_Pill_Dispenser_App/components/patientCard.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'caretakerViewPatientScreen.dart';
import 'caretakerViewScheduleScreen.dart';

class CaretakerPatientListScreen extends StatefulWidget {
  @override
  State<CaretakerPatientListScreen> createState() =>
      _CaretakerPatientListScreenState();
}

class _CaretakerPatientListScreenState
    extends State<CaretakerPatientListScreen> {
  @override
  void initState() {
    super.initState();
    getPatientList();
  }

  @override
  Widget build(BuildContext context) {
    var patientWidgets = [];
    patientIds.forEach((patientId) {
      patientWidgets.add(PatientCard(patientId: patientId));
      patientWidgets.add(Divider(color: Colors.black));
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Pill Dispenser'),
          backgroundColor: ColorThemes.appbarColor,
        ),
        body: Container(
            margin: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            child: ListView(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Patients',
                            style: TextStyle(fontSize: 40, color: Colors.black),
                          ),
                        ),
                        ...patientWidgets
                      ]))
            ])));
  }

  List<String> patientIds = <String>[];

  void getPatientList() async {
    Query patientsRef =

        //TODO: add try catch and snackbar
        FirebaseRefs.dbRef.child(FirebaseRefs.getCaretakerPatientsRef);

    DataSnapshot event = await patientsRef.get();
    Map<dynamic, dynamic> result = event.value as Map;
    print(result.keys);
    patientIds.clear();
    result.keys.forEach((element) {
      patientIds.add(element);
    });
    setState(() {});
  }
}
