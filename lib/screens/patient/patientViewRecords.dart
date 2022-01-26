import 'package:Smart_Pill_Dispenser_App/components/recordListBuilder.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientViewRecords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PatientViewRecordsState();
  }
}

class PatientViewRecordsState extends State<PatientViewRecords> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Records'),
          backgroundColor: ColorThemes.colorOrange,
          foregroundColor: ColorThemes.colorWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: RecordListBuilder(
                patientId: FirebaseAuth.instance.currentUser!.uid),
          ),
        ]));
  }
}
