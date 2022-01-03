import 'package:flutter/material.dart';

class CaretakerLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CaretakerLoginScreenState();
  }
}

class CaretakerLoginScreenState extends State<CaretakerLoginScreen> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;
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
                                        if (value == null) {
                                          return 'Please Enter the Time';
                                        }
                                        if (value.isEmpty) {
                                          return 'Please Enter an Emanil Address';
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return 'Please Enter a Valid Email';
                                        }
                                      },
                                      decoration: InputDecoration(
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
                                        return 'Must be more than 6 charaters';
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
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              )
                            ])),
                      ),
                    ],
                  ))
            ])));
  }
}

void login() {
  debugPrint('Successfully Logged in');
}
