// import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
// import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
// import 'package:flutter/material.dart';
// import 'caretakerViewScheduleScreen.dart';

// class CaretakerEditScheduleScreen extends StatefulWidget {
//   final String patientId;

//   const CaretakerEditScheduleScreen({Key? key, required this.patientId})
//       : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return CaretakerEditScheduleScreenState();
//   }
// }

// class CaretakerEditScheduleScreenState
//     extends State<CaretakerEditScheduleScreen> {
//   var _formKey = GlobalKey<FormState>();

//   TextEditingController timeController = TextEditingController();
//   TextEditingController commentController = TextEditingController();

//   RegExp regex = RegExp(r'^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$');
//   var medicationType = ['Pills', 'Inhalers', 'Liquid Drugs', 'Injections'];
//   var medicationTypeSelected = '';
//   @override
//   void initState() {
//     super.initState();
//     medicationTypeSelected = medicationType[0];
//   }

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Add a Reminder'),
//           backgroundColor: ColorThemes.appbarColor,
//         ),
//         body: Container(
//             margin: EdgeInsets.only(
//               left: 25.0,
//               right: 25.0,
//             ),
//             child: ListView(children: <Widget>[
//               Padding(
//                   padding: EdgeInsets.only(top: screenHeight / 22),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         'Edit the Reminder',
//                         style: TextStyle(fontSize: 40, color: Colors.black),
//                       ),
//                       SizedBox(width: 10, height: 5),
//                       Container(
//                         margin: EdgeInsets.only(left: 20.0, right: 20.0),
//                         child: Form(
//                             key: _formKey,
//                             child: Column(children: <Widget>[
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     right: screenWidth / 2.4,
//                                     top: 20,
//                                     bottom: 5),
//                                 child: Text(
//                                   'Medication Type',
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.black),
//                                 ),
//                               ),
//                               Container(
//                                   width: screenWidth / 1.3,
//                                   height: screenHeight / 12,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(width: 0.5),
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(5.0)),
//                                   ),
//                                   child: Padding(
//                                       padding: EdgeInsets.only(
//                                           top: 5.0, left: 10.0, right: 10.0),
//                                       child: DropdownButtonFormField<String>(
//                                         decoration: InputDecoration(
//                                             border: InputBorder.none),
//                                         items:
//                                             medicationType.map((String value) {
//                                           return DropdownMenuItem<String>(
//                                             value: value,
//                                             child: Text(
//                                               value,
//                                               style: TextStyle(fontSize: 20),
//                                             ),
//                                           );
//                                         }).toList(),
//                                         value: medicationTypeSelected,
//                                         onChanged: (String? newValueSelected) {
//                                           //
//                                         },
//                                       ))),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     right: screenWidth / 1.5, top: 10),
//                                 child: Text(
//                                   'Time',
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.black),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
//                                 child: TextFormField(
//                                     controller: timeController,
//                                     validator: (value) {
//                                       if (value == null) {
//                                         return 'Please Enter the Time';
//                                       }
//                                       if (value.isEmpty) {
//                                         return 'Please Enter the Time';
//                                       }
//                                       if (!regex.hasMatch(value)) {
//                                         return 'Please Enter the time in 00:00 format';
//                                       }
//                                     },
//                                     decoration: InputDecoration(
//                                         contentPadding: EdgeInsets.only(
//                                             top: 6.0, left: 10.0),
//                                         errorStyle: TextStyle(
//                                           color: Colors.redAccent,
//                                           fontSize: 15.0,
//                                         ),
//                                         hintText: '00:00',
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(5.0)))),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     right: screenWidth / 1.9, top: 10),
//                                 child: Text(
//                                   'Comments',
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.black),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
//                                 child: TextFormField(
//                                     maxLines: null,
//                                     minLines: 6,
//                                     controller: commentController,
//                                     decoration: InputDecoration(
//                                         hintText: 'Enter Any Comments',
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(5.0)))),
//                               ),
//                               Row(children: <Widget>[
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       top: 15.0,
//                                       bottom: 5.0,
//                                       left: screenWidth / 10),
//                                   child: DefaultButton(() {
//                                     setState(() {
//                                       if (_formKey.currentState!.validate()) {
//                                         toSaveSchedule(context);
//                                         add();
//                                       }
//                                     });
//                                   }, "Save", ColorThemes.customButtonColor),
//                                 ),
//                                 SizedBox(width: 5, height: 5),
//                                 Padding(
//                                   padding:
//                                       EdgeInsets.only(top: 15.0, bottom: 5.0),
//                                   child: DefaultButton(() {
//                                     setState(() {
//                                       if (_formKey.currentState!.validate()) {
//                                         toSaveSchedule(context);
//                                         add();
//                                       }
//                                     });
//                                   }, "Delete", ColorThemes.deleteButtonColor),
//                                 ),
//                               ])
//                             ])),
//                       ),
//                     ],
//                   ))
//             ])));
//   }

//   void toSaveSchedule(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//           builder: (context) => CaretakerViewScheduleScreen(
//                 patientId: widget.patientId,
//               )),
//     );
//   }

//   void toDeleteSchedule(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//           builder: (context) => CaretakerViewScheduleScreen(
//                 patientId: widget.patientId,
//               )),
//     );
//   }
// }

// void add() {
//   debugPrint('Save');
// }
