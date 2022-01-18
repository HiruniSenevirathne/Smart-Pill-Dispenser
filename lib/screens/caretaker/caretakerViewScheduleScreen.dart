import 'package:Smart_Pill_Dispenser_App/components/scheduleCard.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerAddScheduleItem.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CaretakerViewScheduleScreen extends StatefulWidget {
  final String patientId;
  const CaretakerViewScheduleScreen({Key? key, required this.patientId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CaretakerViewScheduleScreenState();
  }
}

class CaretakerViewScheduleScreenState
    extends State<CaretakerViewScheduleScreen> {
  List<ScheduleItem> patientSchedules = <ScheduleItem>[];

  String dateToday = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // getScheduleList();
  }

  Widget scheduleListBuilder(BuildContext context) {
    Query schedulesRef = FirebaseRefs.dbRef
        .child(FirebaseRefs.getScheduleListRef(widget.patientId));

    return StreamBuilder(
        stream: schedulesRef.onValue,
        builder: (context, AsyncSnapshot dataSnapshot) {
          List<Widget> listdata = [];
          if (dataSnapshot.hasData) {
            print(dataSnapshot.hasData);
            DatabaseEvent event = dataSnapshot.data;
            if (event.snapshot.exists) {
              Map<dynamic, dynamic> result = event.snapshot.value as Map;

              print(result.values);

              patientSchedules.clear();
              result.keys.forEach((key) {
                var element = result[key];
                patientSchedules.add(ScheduleItem.fromJson(element, key));
              });
              listdata.addAll(patientSchedules.where((element) {
                print(element.date);
                print(dateToday);
                return element.date == dateToday.toString();
              }).map((schedule) {
                return ScheduleCard(
                  patientId: widget.patientId,
                  scheduleItem: schedule,
                );
              }).toList());
            }
          }
          if (listdata.length == 0) {
            listdata.add(
              Text("Please add schedule items."),
            );
          }

          return SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[...listdata]),
            ]),
          );
        });
  }

  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedules'),
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
                    toAddSchedule(context);
                  }),
            ),
          )
        ],
      ),
      body: Container(
        child: ListView(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                top: screenHeight / 35,
                left: 33,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomScrollView(shrinkWrap: true, slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
                      sliver: scheduleListBuilder(context),
                    ),
                  ]),
                ],
              ))
        ]),
      ),
    );
  }

  // void getScheduleList() async {
  //   Query schedulesRef =

  //       //TODO: add try catch and snackbar
  //       FirebaseRefs.dbRef
  //           .child(FirebaseRefs.getScheduleListRef(widget.patientId));

  //   DataSnapshot event = await schedulesRef.get();
  //   Map<dynamic, dynamic> result = event.value as Map;
  //   print("schedues -----");
  //   print(result.values);

  //   patientSchedules.clear();
  //   result.keys.forEach((key) {
  //     var element = result[key];
  //     patientSchedules.add(ScheduleItem.fromJson(element, key));
  //   });
  //   setState(() {});
  // }

  void toAddSchedule(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CaretakerAddScheduleItemScreen(
          patientId: widget.patientId,
          isEdit: false,
        ),
      ),
    );
  }
}
