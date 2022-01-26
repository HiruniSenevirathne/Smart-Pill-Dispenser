import 'package:Smart_Pill_Dispenser_App/components/getImageAsset.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart';
import 'package:Smart_Pill_Dispenser_App/modules/patient.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/CaretakerViewPatientRecords.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerViewPatientScreen.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerViewScheduleScreen.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PatientCard extends StatefulWidget {
  final String patientId;

  const PatientCard({Key? key, required this.patientId}) : super(key: key);
  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  UserInfo? patient;
  bool isLoading = true;

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/avater.png');
    Image image = Image(
      image: assetImage,
    );
    return Container(
      child: image,
    );
  }

  @override
  void initState() {
    super.initState();
    loadPatientInfo();
  }

  void loadPatientInfo() async {
    try {
      String ref = FirebaseRefs.getUserInfoRef(widget.patientId);
      Query patientRef = FirebaseRefs.dbRef.child(ref);

      DataSnapshot event = await patientRef.get();
      Map<dynamic, dynamic> result = event.value as Map;
      print(result);
      patient = UserInfo.fromJson(result);
      isLoading = false;
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Row(children: <Widget>[
        SizedBox(
          width: 75.0,
          height: 75.0,
          child: toGetPatientImage(),
        ),
        SizedBox(width: 20, height: 5),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          isLoading || patient == null
              ? CircularProgressIndicator()
              : Text(
                  patient!.firstName + " " + patient!.lastName,
                  style: TextStyle(
                      fontSize: 20,
                      color: ColorThemes.colorBlue,
                      fontWeight: FontWeight.bold),
                ),
          SizedBox(width: 5, height: 10),
          Row(children: <Widget>[
            new MaterialButton(
                height: 43.0,
                minWidth: 70.0,
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: ColorThemes.colorGreen,
                textColor: Colors.white,
                child: Text(
                  'View',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  toViewPatient(context);
                }),
            SizedBox(width: 5, height: 5),
            new MaterialButton(
                height: 43.0,
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: ColorThemes.colorGreen,
                textColor: Colors.white,
                child: Text(
                  'Schedule',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  toViewSchedule(context);
                }),
            SizedBox(width: 5, height: 5),
            new MaterialButton(
                height: 43.0,
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: ColorThemes.colorGreen,
                textColor: Colors.white,
                child: Text(
                  'Records',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  toViewRecords(context);
                }),
          ]),
        ])
      ]),
    );
  }

  void toViewPatient(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              CaretakerViewPatientScreen(patientId: widget.patientId)),
    );
  }

  void toViewSchedule(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              CaretakerViewScheduleScreen(patientId: widget.patientId)),
    );
  }

  void toViewRecords(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CaretakerViewPateintRecords(
                patientId: widget.patientId,
              )),
    );
  }

  Widget toGetPatientImage() {
    toGetImage() async {
      String imgeDbRef =
          FirebaseRefs.getPatientAccountImageIdRef(widget.patientId);
      Query imageRef = FirebaseRefs.dbRef.child(imgeDbRef);
      print(imgeDbRef);
      DataSnapshot event = await imageRef.get();
      print(event.value);
      // Map<dynamic, dynamic> result = event.value as Map;
      // print("------------------------");
      // print(event.value);
      final ref = FirebaseStorage.instance.ref().child(event.value.toString());
      var url = await ref.getDownloadURL();
      print(url);
      return url;
    }

    return FutureBuilder<String>(
        future: toGetImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: CachedNetworkImage(
                imageUrl: snapshot.data.toString(),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 90,
                ),
              ),
            );
          }
          return GetImageAsset();
        });
  }
}
