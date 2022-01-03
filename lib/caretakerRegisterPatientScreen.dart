import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegisterPatientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPatientScreenState();
  }
}

class RegisterPatientScreenState extends State<RegisterPatientScreen> {
  final database = FirebaseDatabase.instanceFor(
          app: Firebase.apps.first,
          databaseURL:
              "https://smartpilldispenser-8714f-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref();

  var _formKey = GlobalKey<FormState>();

  TextEditingController patientNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController caretakerNameController = TextEditingController();

  RegExp regex = RegExp(r'^[a-zA-z]+([\s][a-zA-Z]+)*$');
  RegExp regexAge = RegExp(r'^[0-9]{0,3}$');

  @override
  Widget build(BuildContext context) {
    final patientsRef = database.child('/patients');

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Pill Dispenser'),
          backgroundColor: Color(0xff140078),
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
                      Text(
                        'Register Your Patient',
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
                                    right: screenWidth / 2.2, top: 20),
                                child: Text(
                                  'Patient\'s Name',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 5.0),
                                  child: TextFormField(
                                      controller: patientNameController,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please Enter the Time';
                                        }
                                        if (value.isEmpty) {
                                          return 'Please Enter a Name';
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return 'Please Enter a Valid Name';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15.0,
                                          ),
                                          hintText:
                                              'Enter Your Patient\'s Name',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5.0))))),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 2, top: 10),
                                child: Text(
                                  'Patient\'s Age',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: TextFormField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please Enter the Time';
                                      }
                                      if (value.isEmpty) {
                                        return 'Please Enter a Age';
                                      }
                                      if (!regexAge.hasMatch(value)) {
                                        return 'Please Enter a Valid Value';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15.0,
                                        ),
                                        hintText: 'Enter Your Patient\'s Age',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 2.5, top: 10),
                                child: Text(
                                  'Caretaker\'s Name',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: TextFormField(
                                    controller: caretakerNameController,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please Enter the Time';
                                      }
                                      if (value.isEmpty) {
                                        return 'Please Enter a Name';
                                      }
                                      if (!regex.hasMatch(value)) {
                                        return 'Please Enter a Valid Name';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15.0,
                                        ),
                                        hintText: 'Enter Caretaker\'s Name',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 2.25, top: 10),
                                child: Text(
                                  'Upload a Photo',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, bottom: 5.0),
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
                                      'Next',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    onPressed: () async {
                                      // setState(() {
                                      // if (_formKey.currentState!.validate()) {
                                      //   next();

                                      try {
                                        UserCredential userCredential =
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email:
                                                        "barry.allen@example.com",
                                                    password:
                                                        "SuperSecretPassword!");
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          print(
                                              'The password provided is too weak.');
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          print(
                                              'The account already exists for that email.');
                                        }
                                      } catch (e) {
                                        print(e);
                                      }

// https://firebase.flutter.dev/docs/auth/usage/

// try {
//   UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: "barry.allen@example.com",
//     password: "SuperSecretPassword!"
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {
//     print('No user found for that email.');
//   } else if (e.code == 'wrong-password') {
//     print('Wrong password provided for that user.');
//   }
// }

                                      try {
                                        patientsRef.push().set({
                                          'patientName': 'Hiruni',
                                          'patientAge': '24'
                                        });
                                        print('next');
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                    // }
                                    // });
                                    ),
                              ),
                            ])),
                      ),
                    ],
                  ))
            ])));
  }
}

void next() {
  debugPrint('Next');
}
