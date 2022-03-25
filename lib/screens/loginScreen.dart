import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/screens/resetPasswordScreen.dart';
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

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  String mode = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                        'Sign In',
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
                                padding: EdgeInsets.only(
                                    right: screenWidth / 1.8, top: 10),
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: TextFormField(
                                    obscureText: _isObscure,
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Your Password';
                                      }

                                      if (value.length < 7) {
                                        return 'Must be more than 6 charaters';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 6.0, left: 10.0),
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
                                    left: screenWidth / 2.3, bottom: 20.0),
                                child: TextButton(
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    onPressed: () => {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetScreen()),
                                          )
                                        }),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: DefaultButton(() {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      loginUser();
                                    }
                                  });
                                }, "Sign In", ColorThemes.colorGreen),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen()),
                                  );
                                },
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

  void loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      print(userCredential.user);
      print(userCredential.credential);
      final prefs = await SharedPreferences.getInstance();
      final key = 'mode';
      final value =
          prefs.getString(key) ?? EnumToString.convertToString(Mode.caretaker);
      print('read: $value');

      if (value == EnumToString.convertToString(Mode.caretaker)) {
        saveNewMode(EnumToString.convertToString(Mode.caretaker));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CaretakerHomeScreen()),
        );
        print('logged as caretaker');
        Fluttertoast.showToast(
            msg: "Successfully Logged as Caretaker",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        saveNewMode(EnumToString.convertToString(Mode.patient));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PatientHomeScreen()),
        );
        print('logged as patient');
        Fluttertoast.showToast(
            msg: "Successfully Logged as Patient",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(
            msg: "No user found for that email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
            msg: "Wrong password provided for the user",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  saveNewMode(String modeVal) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'mode';

      prefs.setString(key, modeVal);

      FirebaseRefs.dbRef.child(FirebaseRefs.getMyAccountInfoRef).update({
        'mode': modeVal,
      });
    } catch (err) {
      print(["new mode save error", err]);
    }
  }
}
