import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'caretakerHomeScreen.dart';

class CaretakerProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CaretakerProfileScreenState();
  }
}

class CaretakerProfileScreenState extends State<CaretakerProfileScreen> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RegExp regexName = RegExp(r'^[a-zA-z]+([\s][a-zA-Z]+)*$');
  RegExp regexPhone = RegExp(r'^[0-9]{10}$');

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
                        'Caretaker Profile',
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
                                  'Full Name',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: TextFormField(
                                      controller: nameController,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please Enter a Name';
                                        }
                                        if (value.isEmpty) {
                                          return 'Please Enter a Name';
                                        }
                                        if (!regexName.hasMatch(value)) {
                                          return 'Please Enter a Valid Name';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 6.0, left: 10.0),
                                          errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15.0,
                                          ),
                                          hintText: 'Enter Your Phone Number',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5.0))))),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 1.8, top: 20),
                                child: Text(
                                  'Phone Number',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: TextFormField(
                                      controller: phoneController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter a Phone Number';
                                        }
                                        if (!regexPhone.hasMatch(value)) {
                                          return 'Please Enter a Valid Phone Number';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 6.0, left: 10.0),
                                          errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15.0,
                                          ),
                                          hintText: 'Enter Your Phone Number',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5.0))))),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, bottom: 5.0),
                                child: new MaterialButton(
                                    height: 40.0,
                                    minWidth: 80.0,
                                    padding: EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 40,
                                        right: 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color: Color(0xff512DA8),
                                    textColor: Colors.white,
                                    child: Text(
                                      'Save',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_formKey.currentState!.validate()) {
                                          updateCaretakerProfile();
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

  void updateCaretakerProfile() {
    try {
      FirebaseRefs.dbRef.child(FirebaseRefs.getCaretakerInfoRef).update({
        'phone': phoneController.text,
        'name': nameController.text,
        'updated_at': DateTime.now().toUtc().millisecondsSinceEpoch,
      });
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
      );
    } catch (err) {
      print(err);
    }
  }
}
