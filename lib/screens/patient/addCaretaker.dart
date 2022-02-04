import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/screens/patient/patientHomeScreen.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCaretakerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCaretakerScreenState();
  }
}

class AddCaretakerScreenState extends State<AddCaretakerScreen> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

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
                                            fontSize: 18,
                                            color: ColorThemes.colorBlue),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 5.0),
                                        child: TextFormField(
                                            controller: emailController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Enter an Email Address';
                                              }

                                              if (!EmailValidator.validate(
                                                  value)) {
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
                                                    'Enter Caretaker\'s Email Address',
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
                                            add();
                                          }
                                        });
                                      }, "Add", ColorThemes.colorGreen),
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

          await FirebaseRefs.dbRef
              .child(FirebaseRefs.getMyCaretakersRef + "/${caretakerUid}")
              .update({
            'caretakerId': caretakerUid,
            'caretakerEmail': caretakerEmail
          });

          await FirebaseRefs.dbRef
              .child(FirebaseRefs.getSpecificCaretakerPatientsRef(
                  caretakerUid, patientId))
              .update({
            'patient_id': patientId,
            'patient_email': FirebaseAuth.instance.currentUser!.email
          });
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PatientHomeScreen()),
          );
          Fluttertoast.showToast(
              msg: "Caretaker Added Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          throw "Email not found";
        }
      } else {
        throw "Email not found";
      }
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Can\'t Add Caretaker!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
