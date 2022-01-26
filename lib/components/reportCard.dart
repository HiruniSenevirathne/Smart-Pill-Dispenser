import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerAddScheduleItem.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatefulWidget {
  final ScheduleItem scheduleItem;
  final String patientId;
  final bool? isPatient;
  final double padding;

  const ReportCard(
      {Key? key,
      required this.patientId,
      required this.scheduleItem,
      this.isPatient,
      required this.padding})
      : super(key: key);
  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  @override
  void initState() {
    super.initState();
  }

  // void Function(BuildContext)? deleteSchedule;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorThemes.colorYellw,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        width: screenWidth / 1.2,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: widget.padding, left: 30),
                        child: Text(
                          "Medication Type :",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: widget.padding, right: 30),
                      child: Text(
                        widget.scheduleItem.medicationType,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorThemes.colorBlue),
                      ),
                    )
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: widget.padding, left: 30),
                        child: Text(
                          "Time for Medication :",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: widget.padding, right: 30),
                      child: Text(
                        widget.scheduleItem.time,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorThemes.colorBlue),
                      ),
                    )
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: widget.padding, left: 30),
                        child: Text(
                          "Status :",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: widget.padding, right: 30),
                      child: Text(
                        widget.scheduleItem.status.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorThemes.colorBlue),
                      ),
                    )
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: widget.padding, left: 30),
                        child: Text(
                          "Dispensed Time :",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: widget.padding, right: 30),
                      child: Text(
                        widget.scheduleItem.dispensedTime.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorThemes.colorBlue),
                      ),
                    )
                  ]),
              widget.scheduleItem.comment != ""
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: widget.padding, left: 30, bottom: 20.0),
                              child: Text(
                                "Comment :",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: widget.padding, right: 30, bottom: 20.0),
                            child: Text(
                              widget.scheduleItem.comment,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 10,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorThemes.colorBlue),
                            ),
                          ),
                        ])
                  : Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, bottom: 30.0),
                    ),
              // widget.scheduleItem.comment != ""
              //     ? Padding(
              //         padding: EdgeInsets.only(
              //             left: 25.0, right: 25.0, top: 10.0, bottom: 20.0),
              //         child: Text(
              //           widget.scheduleItem.comment,
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 10,
              //           softWrap: true,
              //           textAlign: TextAlign.center,
              //           style: TextStyle(fontSize: 18, color: Colors.black),
              //         ))
              //     : Padding(
              //         padding:
              //             EdgeInsets.only(left: 25.0, right: 25.0, bottom: 30.0),
              //       ),
            ]),
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
    // print(formattedDate);
    String formatDate =
        new DateFormat("MMM d").format(formattedDate).toString();
    // print(formatDate);
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
