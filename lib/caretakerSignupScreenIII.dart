import 'package:flutter/material.dart';

class CaretakerSignupScreenIII extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CaretakerSignupScreenIIIState();
  }
}

class CaretakerSignupScreenIIIState extends State<CaretakerSignupScreenIII> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isObscure = true;
  var confirmPass;
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
                      SizedBox(width: 10, height: 5),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 1.78, top: 20),
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 5.0),
                                  child: TextFormField(
                                      obscureText: _isObscure,
                                      controller: passwordController,
                                      validator: (String? value) {
                                        confirmPass = value;
                                        if (value == null) {
                                          return 'Please Enter the Time';
                                        }
                                        if (value.isEmpty) {
                                          return "Please Enter New Password";
                                        } else if (value.length < 6) {
                                          return "Password must be atleast 6 characters long";
                                        } else {
                                          return null;
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
                                                  BorderRadius.circular(
                                                      5.0))))),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth / 2.6, top: 10),
                                child: Text(
                                  'Confirm Password',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: TextFormField(
                                    obscureText: _isObscure,
                                    controller: confirmPasswordController,
                                    validator: (String? value) {
                                      if (value == null) {
                                        return 'Please Enter the Time';
                                      }
                                      if (value.isEmpty) {
                                        return "Please Re-Enter New Password";
                                      } else if (value.length < 6) {
                                        return "Password must be atleast 6 characters long";
                                      } else if (value != confirmPass) {
                                        return "Password must be same as above";
                                      } else {
                                        return null;
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
                                        hintText: 'Confirm Your Password',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)))),
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
                                      'Sign Up',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_formKey.currentState!.validate()) {
                                          signup();
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

void signup() {
  debugPrint('Successfully Signed Up');
}
