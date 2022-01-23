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
        title: Text('Your Patients'),
        backgroundColor: ColorThemes.colorOrange,
        foregroundColor: ColorThemes.colorWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              getPatientList();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            getPatientList();
          },
          child: ListView(children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 1),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Padding(
                      //   padding: EdgeInsets.only(top: 20),
                      //   child: Text(
                      //     'Patients',
                      //     style: TextStyle(fontSize: 40, color: ColorThemes.colorBlue),
                      //   ),
                      // ),
                      ...patientWidgets
                    ]))
          ]),
        ),
      ),
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
      const snackBar = SnackBar(
        content: Text('Can\'t Load Patients\' Information!!!!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
