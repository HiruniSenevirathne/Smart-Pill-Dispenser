import 'package:Smart_Pill_Dispenser_App/components/reportCard.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class RecordListBuilderUI extends StatelessWidget {
  final String patientId;
  final List<ScheduleItem> listdata;
  RecordListBuilderUI(this.patientId, this.listdata);
  @override
  Widget build(BuildContext context) {
    return GroupedListView<ScheduleItem, String>(
        elements: listdata,
        groupBy: (schedule) => schedule.date,
        groupSeparatorBuilder: (String groupByValue) {
          String formatDate = new DateFormat("MMM d")
              .format(DateTime.parse(groupByValue))
              .toString();
          print("date" + formatDate);
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
        itemComparator: (item1, item2) => item1.date.compareTo(item2.date),
        useStickyGroupSeparators: false,
        floatingHeader: true,
        order: GroupedListOrder.DESC,
        itemBuilder: (context, schedule) {
          return Container(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
            child: ReportCard(
              patientId: patientId,
              scheduleItem: schedule,
              isPatient: true,
              padding: 25,
            ),
          );
        });
  }
}
