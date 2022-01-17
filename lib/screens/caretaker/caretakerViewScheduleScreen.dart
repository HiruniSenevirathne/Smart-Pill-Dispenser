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
  String dateToday = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getScheduleList();
  }

  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('Schedules'),
          backgroundColor: ColorThemes.appbarColor,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: screenWidth / 15),
                child: SizedBox(
                    width: 35.0,
                    height: 5.0,
                    child: new FloatingActionButton(
                        child: new Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          toAddSchedule(context);
                        })))
          ],
        ),
        body: Container(
            child: ListView(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: screenHeight / 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        'Schedule',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      )),
                  SizedBox(width: 10, height: 25),
                  Container(
                      height: screenHeight,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: ColorThemes.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60.0),
                          topLeft: Radius.circular(60.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: CustomScrollView(shrinkWrap: true, slivers: <
                            Widget>[
                          SliverPadding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  right: 0.0,
                                  left: 0.0,
                                  bottom: 80.0),
                              sliver: SliverList(
                                  delegate: SliverChildListDelegate(<Widget>[
                                Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ...patientSchedules.where((element) {
                                        print(element.date);
                                        print(dateToday);
                                        return element.date ==
                                            dateToday.toString();
                                      }).map((schedule) {
                                        return ScheduleCard(
                                          patientId: widget.patientId,
                                          scheduleItem: schedule,
                                        );
                                      }).toList()
                                    ]),
                              ])))
                        ]),
                      ))
                ],
              ))
        ])));
  }

  List<ScheduleItem> patientSchedules = <ScheduleItem>[];
  void getScheduleList() async {
    Query schedulesRef =

        //TODO: add try catch and snackbar
        FirebaseRefs.dbRef
            .child(FirebaseRefs.getScheduleListRef(widget.patientId));

    DataSnapshot event = await schedulesRef.get();
    Map<dynamic, dynamic> result = event.value as Map;
    print("schedues -----");
    print(result.values);

    patientSchedules.clear();
    result.keys.forEach((key) {
      var element = result[key];
      patientSchedules.add(ScheduleItem.fromJson(element, key));
    });
    setState(() {});
  }

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
