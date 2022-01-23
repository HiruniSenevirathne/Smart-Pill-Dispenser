import 'package:Smart_Pill_Dispenser_App/components/getImageAsset.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditUserProfile extends StatefulWidget {
  final String? userId;

  const EditUserProfile({Key? key, required this.userId}) : super(key: key);
  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  UserInfo? user;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp regexName = RegExp(r'^[a-zA-z]+([\s])*$');
  bool? isEdit = false;
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  void loadUserInfo() async {
    try {
      String ref = FirebaseRefs.getMyAccountInfoRef;
      Query userRef = FirebaseRefs.dbRef.child(ref);

      DataSnapshot event = await userRef.get();
      Map<dynamic, dynamic> result = event.value as Map;
      print("------------------------");
      print(result);
      user = UserInfo.fromJson(result);
      print(user!.firstName);
      emailController.text = user!.email;
      firstNameController.text = user!.firstName;
      lastNameController.text = user!.lastName;
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        left: 25.0,
        right: 10.0,
      ),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: screenHeight / 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Container(
                  margin: EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.0,
                              left: screenWidth / 8,
                            ),
                            child: SizedBox(
                              width: 200.0,
                              height: 200.0,
                              child: GetImageAsset(),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 105, top: 115),
                              child: TextButton(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ]),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 15.0),
                                child: Text(
                                  'First Name',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: ColorThemes.colorBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 15.0),
                                child: Text(
                                  " :",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: ColorThemes.colorBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 15.0, left: 15),
                                  child: TextFormField(
                                    controller: firstNameController,
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
                                          bottom: 0, left: 10.0),
                                      errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.0,
                                      ),
                                      hintText: user!.firstName,
                                      focusedBorder: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                        Row(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Last Name',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: ColorThemes.colorBlue,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              " :",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorThemes.colorBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 15.0, left: 15),
                              child: TextFormField(
                                controller: lastNameController,
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
                                    contentPadding: EdgeInsets.only(left: 10.0),
                                    errorStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 15.0,
                                    ),
                                    hintText: user!.lastName,
                                    focusedBorder: UnderlineInputBorder()),
                              ),
                            ),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: ColorThemes.colorBlue),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              " :",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorThemes.colorBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 15.0, left: 15),
                                  child: TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please a Email Address';
                                        }
                                        if (value.isEmpty) {
                                          return 'Please a Email Address';
                                        }
                                        if (!regexName.hasMatch(value)) {
                                          return 'Please Enter a Valid Email';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 10.0),
                                          errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15.0,
                                          ),
                                          hintText: user!.email,
                                          focusedBorder:
                                              UnderlineInputBorder())))),
                        ]),
                      ],
                    ),
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}

// Widget getImageAsset() {
//   AssetImage assetImage = AssetImage('images/avater.jpg');
//   Image image = Image(
//     image: assetImage,
//   );
//   return Container(
//     child: image,
//   );
// }
