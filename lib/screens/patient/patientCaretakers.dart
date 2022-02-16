import 'package:Smart_Pill_Dispenser_App/components/caretakerCard.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/screens/patient/addCaretaker.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PatientCaretakers extends StatefulWidget {
  @override
  State<PatientCaretakers> createState() => _PatientCaretakersState();
}

class _PatientCaretakersState extends State<PatientCaretakers> {
  @override
  void initState() {
    super.initState();
  }

  Query caretakersRef =
      FirebaseRefs.dbRef.child(FirebaseRefs.getMyCaretakersRef);
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Caretakers'),
        backgroundColor: ColorThemes.colorOrange,
        foregroundColor: ColorThemes.colorWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth / 15),
            child: SizedBox(
              width: 35.0,
              height: 5.0,
              child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    toAddCaretaker(context);
                  }),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
        ),
        child: StreamBuilder<Object>(
            stream: caretakersRef.onValue,
            builder: (context, AsyncSnapshot dataSnapshot) {
              print(["Info", dataSnapshot.data]);

              if (!dataSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                DatabaseEvent event = dataSnapshot.data;

                List<Widget> caretakerWidgets = [];
                if (event.snapshot.exists) {
                  Map<dynamic, dynamic> result = event.snapshot.value as Map;

                  result.keys.forEach((element) {
                    caretakerWidgets.add(CaretakerCard(
                        key: Key("${element}"), caretakerId: element));
                    caretakerWidgets.add(Divider(color: Colors.black));
                  });
                }
                return ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: caretakerWidgets))
                ]);
              }
            }),
      ),
    );
  }

  void toAddCaretaker(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddCaretakerScreen()),
    );
  }
}
