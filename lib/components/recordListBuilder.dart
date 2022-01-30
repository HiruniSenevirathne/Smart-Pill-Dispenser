import 'package:Smart_Pill_Dispenser_App/components/RecordListBuilderUI.dart';
import 'package:Smart_Pill_Dispenser_App/components/reportCard.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class RecordListBuilder extends StatefulWidget {
  final String patientId;
  const RecordListBuilder({Key? key, required this.patientId})
      : super(key: key);
  @override
  State<RecordListBuilder> createState() => _RecordListBuilderState();
}

class _RecordListBuilderState extends State<RecordListBuilder> {
  var currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Query schedulesRef = FirebaseRefs.dbRef
        .child(FirebaseRefs.getScheduleListRef(widget.patientId));

    return StreamBuilder(
        stream: schedulesRef.onValue,
        builder: (context, AsyncSnapshot dataSnapshot) {
          List<ScheduleItem> listdata = [];
          if (dataSnapshot.hasData) {
            DatabaseEvent event = dataSnapshot.data;
            if (event.snapshot.exists) {
              Map<dynamic, dynamic> result = event.snapshot.value as Map;

              result.keys.forEach((key) {
                var element = result[key];
                var item = ScheduleItem.fromJson(element, key);

                DateTime elementDate = DateTime.parse(item.date);
                if (elementDate
                    .isBefore(currentDate.subtract(Duration(days: 1)))) {
                  listdata.add(item);
                }
              });
              listdata.sort((a, b) => a.time.compareTo(b.time));
            }
          }

          return RecordListBuilderUI(widget.patientId, listdata);
        });
  }
}
