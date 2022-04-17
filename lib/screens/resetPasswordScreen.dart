import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/screens/starterScreen.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'caretaker/caretakerHomeScreen.dart';
import 'patient/patientHomeScreen.dart';
import 'signupScreen.dart';

class ResetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResetScreenState();
  }
}

class ResetScreenState extends State<ResetScreen> {
  var _formKey = GlobalKey<FormState>();
  String mode = "";
  TextEditingController emailController = TextEditingController();

  bool _isObscure = true;

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
                        'Reset Your Password',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                      SizedBox(width: 10, height: 5),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 1.55, top: 20),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 5.0),
                                  child: TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter an Email Address';
                                        }

                                        if (!EmailValidator.validate(value)) {
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
                                          hintText: 'Enter Your Email Address',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5.0))))),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        FirebaseAuth.instance
                                            .sendPasswordResetEmail(
                                                email: emailController.text);
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorThemes.colorGreen,
                                          padding: const EdgeInsets.only(
                                              top: 15.0,
                                              bottom: 15.0,
                                              left: 12.0,
                                              right: 12.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: const Text('Send Request'))),
                              GestureDetector(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Don\'t have an account?',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                        Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ]),
                                ),
                              )
                            ])),
                      ),
                    ],
                  ))
            ])));
  }

 
}
