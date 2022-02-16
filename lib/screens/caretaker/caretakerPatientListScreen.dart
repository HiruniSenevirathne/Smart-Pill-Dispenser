import 'package:Smart_Pill_Dispenser_App/components/patientCard.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Query patientsRef =
      FirebaseRefs.dbRef.child(FirebaseRefs.getCaretakerPatientsRef);
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
          child: StreamBuilder<Object>(
              stream: patientsRef.onValue,
              builder: (context, AsyncSnapshot dataSnapshot) {
                print(["Info", dataSnapshot.data]);

                if (!dataSnapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
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
      Fluttertoast.showToast(
          msg: "Can\'t Load Patients\' Information!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
