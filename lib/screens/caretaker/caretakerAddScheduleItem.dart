import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import 'caretakerViewScheduleScreen.dart';
import 'package:flutter/material.dart';

class CaretakerAddScheduleItemScreen extends StatefulWidget {
  final String patientId;
  final bool isEdit;
  final String? scheduleId;
  const CaretakerAddScheduleItemScreen(
      {Key? key,
      required this.patientId,
      this.scheduleId,
      required this.isEdit})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CaretakerAddScheduleScreenState_();
  }
}

class CaretakerAddScheduleScreenState_
    extends State<CaretakerAddScheduleItemScreen> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController commentController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  RegExp regex = RegExp(r'^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$');

  var medicationType = ['Pills', 'Inhalers', 'Liquid Drugs', 'Injections'];
  var medicationTypeSelected = '';

  @override
  void initState() {
    super.initState();
    medicationTypeSelected = medicationType[0];
    dateController.text = "";
    if (widget.isEdit) {
      getScheduleInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    TimeOfDay selectedTime = TimeOfDay.now();

    return Scaffold(
        appBar: AppBar(
          title: widget.isEdit == false
              ? Text('Add a Schedule')
              : Text('Edit Schedules'),
          backgroundColor: ColorThemes.colorOrange,
          foregroundColor: ColorThemes.colorWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            child: ListView(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: screenHeight / 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 2.5,
                                    top: 10,
                                    bottom: 5),
                                child: Text(
                                  'Medication Type',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorThemes.colorBlue),
                                ),
                              ),
                              Container(
                                  width: screenWidth / 1.2,
                                  height: screenHeight / 13,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(width: 0.5))),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 5.0, left: 10.0),
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 6.0, left: 0.0),
                                            border: InputBorder.none),
                                        items:
                                            medicationType.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          );
                                        }).toList(),
                                        value: medicationTypeSelected,
                                        onChanged: (String? newValueSelected) {
                                          _onDropDownItemSelected(
                                              newValueSelected!);
                                        },
                                      ))),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: screenWidth / 1.9,
                                  top: 20,
                                ),
                                child: Text(
                                  'Enter Time',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorThemes.colorBlue),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: TextField(
                                      controller: timeController,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.access_alarms),
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: selectedTime,
                                          initialEntryMode:
                                              TimePickerEntryMode.input,
                                          confirmText: "CONFIRM",
                                          cancelText: "NOT NOW",
                                        );

                                        if (pickedTime != null) {
                                          print(pickedTime.format(context));

                                          setState(() {
                                            timeController.text = pickedTime
                                                .format(context)
                                                .toString();
                                          });
                                        }
                                      })),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: screenWidth / 1.9,
                                  top: 20,
                                ),
                                child: Text(
                                  'Enter Date',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorThemes.colorBlue),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: TextField(
                                      controller: dateController,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.calendar_today),
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2022),
                                                lastDate: DateTime(2101));

                                        if (pickedDate != null) {
                                          print(pickedDate);
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          print(formattedDate);

                                          setState(() {
                                            dateController.text = formattedDate;
                                          });
                                        }
                                      })),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 1.9, top: 10),
                                child: Text(
                                  'Comments',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorThemes.colorBlue),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: TextFormField(
                                    maxLines: null,
                                    minLines: 6,
                                    controller: commentController,
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15.0,
                                        ),
                                        hintText: 'Enter Any Comments',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)))),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, bottom: 5.0),
                                child: DefaultButton(() {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      // toAddSchedule(context);
                                      toAddSchedule();
                                    }
                                  });
                                }, "Add", ColorThemes.colorGreen),
                              ),
                            ])),
                      ),
                    ],
                  ))
            ])));
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.medicationTypeSelected = newValueSelected;
    });
  }

  void toAddSchedule() async {
    try {
      var data = {
        'time': timeController.text,
        'date': dateController.text,
        'medication_type': medicationTypeSelected,
        'comment': commentController.text
      };

      if (widget.isEdit && widget.scheduleId != null) {
        await FirebaseRefs.dbRef
            .child(FirebaseRefs.getScheduleItemRef(
                widget.patientId, widget.scheduleId.toString()))
            .update(data);
        print("schedule item updated");
      } else {
        await FirebaseRefs.dbRef
            .child(FirebaseRefs.getNewScheduleItemRef(widget.patientId))
            .update(data);
        print("schedule item created");
      }
      const snackBar = SnackBar(
        content: Text('Schedule Added Successfully'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context).pop();
    } catch (err) {
      print(err);
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Failed to Add Your Schedule'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void getScheduleInfo() async {
    try {
      if (widget.scheduleId != null) {
        String ref = FirebaseRefs.getScheduleItemRef(
            widget.patientId, widget.scheduleId.toString());
        Query patientRef = FirebaseRefs.dbRef.child(ref);

        DataSnapshot event = await patientRef.get();
        Map<dynamic, dynamic> result = event.value as Map;
        print(result['medication_type']);
        medicationTypeSelected = result['medication_type'];
        timeController.text = result['time'];
        dateController.text = result['date'];
        commentController.text = result['comment'];
        setState(() {});
      } else {
        print("empty schedule id !");
      }
    } catch (err) {
      print(err);
      const snackBar = SnackBar(
        content: Text('Can\'t Get Schedule Information'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
