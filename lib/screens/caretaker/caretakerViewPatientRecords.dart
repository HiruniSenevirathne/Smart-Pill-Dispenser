import 'package:Smart_Pill_Dispenser_App/components/RecordListBuilderUI.dart';
import 'package:Smart_Pill_Dispenser_App/components/recordListBuilder.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class CaretakerViewPateintRecords extends StatefulWidget {
  final String patientId;
  const CaretakerViewPateintRecords({Key? key, required this.patientId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CaretakerViewPateintRecordsState();
  }
}

class PatientReportTypes_ {
  static final String Monthly = "Last Month";
  static final String Weekly = "Last Week";
  static final String Daily = "24h";
}

class CaretakerViewPateintRecordsState
    extends State<CaretakerViewPateintRecords> {
  final List<String> durations = [
    PatientReportTypes_.Daily,
    PatientReportTypes_.Weekly,
    PatientReportTypes_.Monthly
  ];
  String durationTypeSelected = PatientReportTypes_.Daily;
  @override
  void initState() {
    super.initState();
    onChangeReportType(PatientReportTypes_.Daily);
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
      body: buildReport(context),
    );
  }

  Widget buildReport(BuildContext context) {
    Query schedulesRef = FirebaseRefs.dbRef
        .child(FirebaseRefs.getScheduleListRef(widget.patientId));

    return StreamBuilder(
        stream: schedulesRef.onValue,
        builder: (context, AsyncSnapshot dataSnapshot) {
          List<ScheduleItem> listdata = [];
          Moment dt1 = Moment.now();
          Moment dt2 = Moment.now();
          var cDate = Moment.now();
          int takenCount = 0;
          int notTakenCount = 0;
          int totalCount = 0;
          String takenPercentage = "";
          String notTakenPercentage = "";

          if (durationTypeSelected == PatientReportTypes_.Daily) {
            dt2 = Moment.parse(cDate.format("yyyy-MM-dd HH:mm"));
            dt1 = dt2.subtract(days: 1);
            print(dt1.format("dd-MM-yyyy HH:mm"));
            print(dt2.format("dd-MM-yyyy HH:mm"));
          } else if (durationTypeSelected == PatientReportTypes_.Weekly) {
            dt2 = Moment.parse(cDate.format("yyyy-MM-dd HH:mm"));
            dt1 = dt2.subtract(weeks: 1);
            print(dt1.format("dd-MM-yyyy HH:mm"));
            print(dt2.format("dd-MM-yyyy HH:mm"));
          } else if (durationTypeSelected == PatientReportTypes_.Monthly) {
            dt2 = Moment.parse(cDate.format("yyyy-MM-dd HH:mm"));
            dt1 = dt2.subtract(months: 1);
            print(dt1.format("dd-MM-yyyy HH:mm"));
            print(dt2.format("dd-MM-yyyy HH:mm"));
          }
          if (dataSnapshot.hasData) {
            DatabaseEvent event = dataSnapshot.data;
            if (event.snapshot.exists) {
              Map<dynamic, dynamic> result = event.snapshot.value as Map;
              DateTime ddt1 = dt1.date;
              DateTime ddt2 = dt2.date;
              result.keys.forEach((key) {
                var element = result[key];
                var item = ScheduleItem.fromJson(element, key);

                DateTime elementDate = DateTime.parse(item.date);
                print(elementDate.toString());
                if (elementDate.millisecondsSinceEpoch >=
                        ddt1.millisecondsSinceEpoch &&
                    elementDate.millisecondsSinceEpoch <=
                        ddt2.millisecondsSinceEpoch) {
                  if (item.status == item.STATUS_Taken) {
                    takenCount++;
                  } else {
                    notTakenCount++;
                  }
                  totalCount++;
                  listdata.add(item);
                }
              });
              listdata.sort((a, b) => a.time.compareTo(b.time));
            }
          }
          takenPercentage =
              ((takenCount / totalCount) * 100).round().toString() + "%";
          notTakenPercentage =
              ((notTakenCount / totalCount) * 100).round().toString() + "%";
          return Column(
            children: [
              Expanded(
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.5))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...durations.map((String value) {
                            return Container(
                              padding: EdgeInsets.all(4),
                              child: TextButton(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: durationTypeSelected == value
                                          ? ColorThemes.colorOrange
                                          : ColorThemes.colorGreen),
                                ),
                                onPressed: () {
                                  onChangeReportType(value);
                                },
                              ),
                            );
                          }).toList(),
                        ]),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Taken: "),
                            Text("${takenCount}  (${takenPercentage})"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Not Taken: "),
                            Text("${notTakenCount}  (${notTakenPercentage})"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: RecordListBuilderUI(widget.patientId, listdata)),
                ]),
              ),
            ],
          );
        });
  }

  void onChangeReportType(String newValueSelected) {
    setState(() {
      this.durationTypeSelected = newValueSelected;
    });
  }
}
