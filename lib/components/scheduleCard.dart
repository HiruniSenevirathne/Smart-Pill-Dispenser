import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerAddScheduleItem.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:intl/intl.dart';
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
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: ColorThemes.colorYellw,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          width: screenWidth / 1.2,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: screenWidth / 1.4),
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel_sharp,
                      color: Colors.grey,
                      size: 26,
                    ),
                    onPressed: () {
                      deleteScheduleItem(context);
                    },
                  ),
                ),
                Text(
                  widget.scheduleItem.medicationType,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            dateFormat(),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: ColorThemes.colorBlue),
                          )),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: ClipRect(
                                    child: Text(
                                  widget.scheduleItem.time,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: ColorThemes.colorBlue),
                                ))),
                          ]),
                    ]),
                widget.scheduleItem.comment != ""
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 10.0, bottom: 20.0),
                        child: Text(
                          widget.scheduleItem.comment,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ))
                    : Padding(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 25.0, bottom: 30.0),
                      ),
              ]),
        ),
      ),
    );
  }

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

  dateFormat() {
    DateTime formattedDate = DateTime.parse(widget.scheduleItem.date);
    print(formattedDate);
    String formatDate =
        new DateFormat("MMM d").format(formattedDate).toString();
    print(formatDate);
    return formatDate;
  }

  void deleteScheduleItem(BuildContext context) async {
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
