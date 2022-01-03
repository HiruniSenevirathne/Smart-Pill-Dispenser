import 'package:flutter/material.dart';

class CaretakerSignupScreenI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CaretakerSignupScreenIState();
  }
}

class CaretakerSignupScreenIState extends State<CaretakerSignupScreenI> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  RegExp regex = RegExp(r'^[a-zA-z]+([\s][a-zA-Z]+)*$');
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
                        'Sign Up',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                      SizedBox(width: 10, height: 10),
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
                                        if (!regex.hasMatch(value)) {
                                          return 'Please Enter a Valid Name';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15.0,
                                          ),
                                          hintText: 'Enter Your Name',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5.0))))),
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
                                    onPressed: () {
                                      setState(() {
                                        if (_formKey.currentState!.validate()) {
                                          next();
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
}

void next() {
  debugPrint('Next');
}
