import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/screens/patient/patientHomeScreen.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddCaretakerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCaretakerScreenState();
  }
}

class AddCaretakerScreenState extends State<AddCaretakerScreen> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            child: ListView(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: screenHeight / 3.5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Add Your Caretaker',
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                        SizedBox(width: 10, height: 5),
                        Container(
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: screenWidth / 2.5, top: 20),
                                      child: Text(
                                        'Caretaker\'s Email',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 5.0),
                                        // child: Container(
                                        //     height: screenHeight / 10,
                                        //     width: screenWidth,
                                        child: TextFormField(
                                            controller: emailController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Enter an Email Address';
                                              }

                                              if (!regex.hasMatch(value)) {
                                                return 'Please Enter a Valid Email';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 6.0, left: 10.0),
                                                errorStyle: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 15.0,
                                                ),
                                                hintText:
                                                    'Enter Your Email Address',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0))))),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0, bottom: 5.0),
                                      child: DefaultButton(() {
                                        setState(() {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // toAddSchedule(context);
                                            add();
                                          }
                                        });
                                      }, "Add", ColorThemes.customButtonColor),
                                    ),
                                  ],
                                )))
                      ]))
            ])));
  }

  void add() async {
    try {
      // print("input email" + emailController.text);
      Query query = FirebaseRefs.dbRef
          .child('/users')
          .orderByChild('info/email')
          .equalTo(emailController.text);
      DataSnapshot event = await query.get();
      if (event.exists) {
        Map<dynamic, dynamic> result = event.value as Map;
        print(result);
        if (result.values.length == 1) {
          // print(result.values.first["info"]["user_id"]);
          String caretakerUid = result.values.first["info"]["user_id"];
          String caretakerEmail = result.values.first["info"]["email"];

          // print(['Caretaker uid', caretakerUid]);
          String patientId = FirebaseAuth.instance.currentUser!.uid;
          String CaretakerRef = "/patients/${patientId}";

          await FirebaseRefs.dbRef.child(CaretakerRef).update({
            'caretaker': {
              'caretakerId': caretakerUid,
              'caretakerEmail': caretakerEmail
            }
          });

          String PatientRef =
              "/caretakers/${caretakerUid}/patients/${patientId}";
          await FirebaseRefs.dbRef.child(PatientRef).update({
            'patient_id': patientId,
            'patient_email': FirebaseAuth.instance.currentUser!.email
          });
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PatientHomeScreen()),
          );
          // print('done');
          //snakbar
        } else {
          throw "Email not found";
        }
      } else {
        throw "Email not found";
      }
    } catch (err) {
      print(err);
      //add snackbar
    }
  }
}
