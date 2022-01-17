import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerAddScheduleItem.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerEditSchedule.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScheduleCard extends StatefulWidget {
  final ScheduleItem scheduleItem;
  final String patientId;

  const ScheduleCard(
      {Key? key, required this.patientId, required this.scheduleItem})
      : super(key: key);
  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  void initState() {
    super.initState();
  }

  // void Function(BuildContext)? deleteSchedule;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: GestureDetector(
            onTap: () {
              toViewSchedule(context);
            },
            child: Slidable(
                key: const ValueKey(0),
                startActionPane: ActionPane(
                  motion: const BehindMotion(),
                  dismissible: DismissiblePane(onDismissed: () {
                    deleteScheduleItem(context);
                  }),
                  children: const [
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 100,
                  width: screenWidth / 1.3,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              widget.scheduleItem.time,
                              style: TextStyle(fontSize: 30),
                            )),
                        SizedBox(width: 50, height: 5),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    widget.scheduleItem.medicationType,
                                    style: TextStyle(fontSize: 22),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    widget.scheduleItem.comment,
                                    style: TextStyle(fontSize: 20),
                                  ))
                            ])
                      ]),
                ))));
  }

  // void toAddSchedule(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //         builder: (context) => CaretakerAddScheduleScreen(
  //               patientId: widget.schedule.scheduleId,
  //             )),
  //   );
  // }

  void toViewSchedule(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CaretakerAddScheduleItemScreen(
                patientId: widget.patientId,
                scheduleId: widget.scheduleItem.scheduleId,
                isEdit: true,
              )),
    );
  }

  deleteScheduleItem(BuildContext context) async {
    try {
      await FirebaseRefs.dbRef
          .child(FirebaseRefs.getScheduleItemRef(
              widget.patientId, widget.scheduleItem.scheduleId))
          .remove();
      //snackbar
    } catch (err) {
      print(err);
      //snackbar
    }
  }
}
