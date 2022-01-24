import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
import 'package:Smart_Pill_Dispenser_App/components/scheduleCard.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:intl/intl.dart';

class PatientScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PatientScheduleScreenState();
  }
}

class PatientScheduleScreenState extends State<PatientScheduleScreen> {
  List<ScheduleItem> mySchedules = <ScheduleItem>[];

  var paginatedLastDate = Moment.now();

  List<String> dateList = [];

  @override
  void initState() {
    super.initState();
    // getScheduleList();
    dateList.add(paginatedLastDate.format('yyyy-MM-dd'));
  }

  Widget scheduleListBuilder(BuildContext context) {
    Query schedulesRef = FirebaseRefs.dbRef.child(
        FirebaseRefs.getScheduleListRef(
            FirebaseAuth.instance.currentUser!.uid));

    return StreamBuilder(
        stream: schedulesRef.onValue,
        builder: (context, AsyncSnapshot dataSnapshot) {
          List<ScheduleItem> listdata = [];
          if (dataSnapshot.hasData) {
            DatabaseEvent event = dataSnapshot.data;
            if (event.snapshot.exists) {
              Map<dynamic, dynamic> result = event.snapshot.value as Map;

              // print(result.values);

              mySchedules.clear();
              result.keys.forEach((key) {
                var element = result[key];
                mySchedules.add(ScheduleItem.fromJson(element, key));
              });

              print(dateList);

              listdata.addAll(mySchedules.where((element) {
                bool canAdd = false;
                dateList.forEach((date) {
                  if (element.date == date) {
                    canAdd = true;
                  }
                });
                return canAdd;
              }));
              listdata.sort((a, b) => a.time.compareTo(b.time));
            }
          }

          return GroupedListView<ScheduleItem, String>(
              elements: listdata,
              groupBy: (schedule) => schedule.date,
              groupSeparatorBuilder: (String groupByValue) {
                String formatDate = new DateFormat("MMM d")
                    .format(DateTime.parse(groupByValue))
                    .toString();
                return Container(
                  padding: EdgeInsets.only(top: 10, bottom: 5, left: 20),
                  alignment: Alignment.topLeft,
                  child: Chip(
                    padding: EdgeInsets.all(10),
                    label: Text(
                      formatDate,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
              itemComparator: (item1, item2) =>
                  item1.date.compareTo(item2.date),
              useStickyGroupSeparators: true,
              floatingHeader: true,
              order: GroupedListOrder.ASC,
              itemBuilder: (context, schedule) {
                return Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: ScheduleCard(
                    patientId: FirebaseAuth.instance.currentUser!.uid,
                    scheduleItem: schedule,
                    isPatient: true,
                    padding: 25,
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
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
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: scheduleListBuilder(context),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
            child: DefaultButton(() {
              setState(() => {toGetFututreSchedules(context)});
            }, ">", ColorThemes.colorGreen),
          ),
        ]));
  }

  void toGetFututreSchedules(BuildContext context) {
    paginatedLastDate = paginatedLastDate.add(days: 1);
    setState(() {
      dateList.add(paginatedLastDate.format('yyyy-MM-dd'));
    });
  }
}
