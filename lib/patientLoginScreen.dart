import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './modules/patient.dart';

class PatientLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PatientLoginScreenState();
  }
}

class PatientLoginScreenState extends State<PatientLoginScreen> {
  final DatabaseReference _patientsRef =
      FirebaseDatabase.instance.ref('patients');
  var _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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
                  padding: EdgeInsets.only(top: screenHeight / 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Login',
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
                                    right: screenWidth / 1.8, top: 20),
                                child: Text(
                                  'Username',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 5.0),
                                  child: TextFormField(
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Your Name',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5.0))))),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 1.8, top: 10),
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: TextFormField(
                                    obscureText: _isObscure,
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please Enter the Time';
                                      }
                                      if (value.isEmpty) {
                                        return 'Please Enter Your Password';
                                      }
                                      if (value.length < 7) {
                                        return 'Must be more than 6 charater';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            icon: Icon(_isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            }),
                                        errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15.0,
                                        ),
                                        hintText: 'Enter Your Password',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth / 2.2, bottom: 20.0),
                                child: Text(
                                  'Fogot Password',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: new MaterialButton(
                                    height: 71.0,
                                    minWidth: 164.0,
                                    padding: EdgeInsets.only(
                                        top: 25,
                                        bottom: 25,
                                        left: 55,
                                        right: 55),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color: Color(0xff512DA8),
                                    textColor: Colors.white,
                                    child: Text(
                                      'Login',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_formKey.currentState!.validate()) {
                                          login();
                                        }
                                      });
                                    }),
                              ),
                            ])),
                      ),
                    ],
                  ))
            ])));
  }

  void savePatient(Patients patients) {
    _patientsRef.push().set(patients.toJson());
  }
}

void login() {
  debugPrint('Successfully Logged in');
}
