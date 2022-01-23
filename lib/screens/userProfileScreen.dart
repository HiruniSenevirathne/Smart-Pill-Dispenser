import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
import 'package:Smart_Pill_Dispenser_App/components/editUserProfile.dart';
import 'package:Smart_Pill_Dispenser_App/components/viewUserProfile.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart';

import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;

  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return UserProfileScreenState();
  }
}

class UserProfileScreenState extends State<UserProfileScreen> {
  UserInfo? user;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp regexName = RegExp(r'^[a-zA-z]+([\s])*$');
  bool? isEdit = false;
  // var _formKey = GlobalKey<FormState>();

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

  // Widget viewUserProfile(BuildContext context) {
  //   var screenHeight = MediaQuery.of(context).size.height;
  //   var screenWidth = MediaQuery.of(context).size.width;
  //   return Container(
  //     margin: EdgeInsets.only(
  //       left: 25.0,
  //       right: 10.0,
  //     ),
  //     child: ListView(
  //       children: <Widget>[
  //         Padding(
  //           padding: EdgeInsets.only(top: screenHeight / 50),
  //           child:
  //               Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
  //                   Widget>[
  //             Container(
  //               margin: EdgeInsets.only(left: 20.0, right: 10.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                       bottom: 10.0,
  //                       left: screenWidth / 8,
  //                     ),
  //                     child: SizedBox(
  //                       width: 200.0,
  //                       height: 200.0,
  //                       child: getImageAsset(),
  //                     ),
  //                   ),
  //                   Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Padding(
  //                           padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
  //                           child: Text(
  //                             'First Name',
  //                             style: TextStyle(
  //                                 fontSize: 22,
  //                                 color: ColorThemes.colorBlue,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
  //                           child: Text(
  //                             " :",
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               fontSize: 18,
  //                               color: ColorThemes.colorBlue,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: Padding(
  //                             padding: EdgeInsets.only(
  //                                 top: 10.0, bottom: 15.0, left: 15),
  //                             child: Text(
  //                               user!.firstName,
  //                               overflow: TextOverflow.ellipsis,
  //                               maxLines: 10,
  //                               softWrap: true,
  //                               style: TextStyle(
  //                                   fontSize: 18, color: Colors.black),
  //                             ),
  //                           ),
  //                         )
  //                       ]),
  //                   Row(children: <Widget>[
  //                     Padding(
  //                       padding: EdgeInsets.only(bottom: 10.0),
  //                       child: Text(
  //                         'Last Name',
  //                         style: TextStyle(
  //                           fontSize: 22,
  //                           fontWeight: FontWeight.bold,
  //                           color: ColorThemes.colorBlue,
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(bottom: 10.0),
  //                       child: Text(
  //                         " :",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                           fontSize: 18,
  //                           color: ColorThemes.colorBlue,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Padding(
  //                         padding: EdgeInsets.only(
  //                             top: 10.0, bottom: 15.0, left: 15),
  //                         child: Text(
  //                           user!.lastName,
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 10,
  //                           softWrap: true,
  //                           style: TextStyle(fontSize: 18, color: Colors.black),
  //                         ),
  //                       ),
  //                     ),
  //                   ]),
  //                   Row(children: <Widget>[
  //                     Padding(
  //                       padding: EdgeInsets.only(bottom: 10.0),
  //                       child: Text(
  //                         'Email',
  //                         style: TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.bold,
  //                             color: ColorThemes.colorBlue),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(bottom: 10.0),
  //                       child: Text(
  //                         " :",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                           fontSize: 18,
  //                           color: ColorThemes.colorBlue,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Padding(
  //                         padding: EdgeInsets.only(
  //                             top: 10.0, bottom: 15.0, left: 15),
  //                         child: Text(
  //                           user!.email,
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 10,
  //                           softWrap: true,
  //                           style: TextStyle(fontSize: 18, color: Colors.black),
  //                         ),
  //                       ),
  //                     ),
  //                   ]),
  //                   // Align(
  //                   //   alignment: Alignment.center,
  //                   //   child: Padding(
  //                   //     padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
  //                   //     child: DefaultButton(() {
  //                   //       setState(() {
  //                   //         if (_formKey.currentState!.validate()) {
  //                   //           // toAddSchedule(context);
  //                   //           toHomePage(context);
  //                   //         }
  //                   //       });
  //                   //     }, "Back", ColorThemes.colorGreen),
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //           ]),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget editUserProfile(BuildContext context) {
  //   var screenHeight = MediaQuery.of(context).size.height;
  //   var screenWidth = MediaQuery.of(context).size.width;
  //   return Container(
  //     margin: EdgeInsets.only(
  //       left: 25.0,
  //       right: 10.0,
  //     ),
  //     child: ListView(
  //       children: <Widget>[
  //         Padding(
  //           padding: EdgeInsets.only(top: screenHeight / 50),
  //           child:
  //               Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
  //                   Widget>[
  //             Container(
  //               margin: EdgeInsets.only(left: 20.0, right: 10.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Stack(children: <Widget>[
  //                     Padding(
  //                       padding: EdgeInsets.only(
  //                         bottom: 10.0,
  //                         left: screenWidth / 8,
  //                       ),
  //                       child: SizedBox(
  //                         width: 200.0,
  //                         height: 200.0,
  //                         child: getImageAsset(),
  //                       ),
  //                     ),
  //                     Center(
  //                       child: TextButton(
  //                         child: Icon(
  //                           Icons.add_a_photo,
  //                           size: 30,
  //                         ),
  //                         onPressed: () {},
  //                       ),
  //                     ),
  //                   ]),
  //                   Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Padding(
  //                           padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
  //                           child: Text(
  //                             'First Name',
  //                             style: TextStyle(
  //                                 fontSize: 22,
  //                                 color: ColorThemes.colorBlue,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
  //                           child: Text(
  //                             " :",
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               fontSize: 18,
  //                               color: ColorThemes.colorBlue,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: Padding(
  //                             padding: EdgeInsets.only(bottom: 15.0, left: 15),
  //                             child: TextFormField(
  //                               controller: firstNameController,
  //                               validator: (value) {
  //                                 if (value == null) {
  //                                   return 'Please Enter a Name';
  //                                 }
  //                                 if (value.isEmpty) {
  //                                   return 'Please Enter a Name';
  //                                 }
  //                                 if (!regexName.hasMatch(value)) {
  //                                   return 'Please Enter a Valid Name';
  //                                 }
  //                               },
  //                               decoration: InputDecoration(
  //                                 contentPadding:
  //                                     EdgeInsets.only(bottom: 0, left: 10.0),
  //                                 errorStyle: TextStyle(
  //                                   color: Colors.redAccent,
  //                                   fontSize: 15.0,
  //                                 ),
  //                                 hintText: user!.firstName,
  //                                 focusedBorder: UnderlineInputBorder(),
  //                               ),
  //                             ),
  //                           ),
  //                         )
  //                       ]),
  //                   Row(children: <Widget>[
  //                     Padding(
  //                       padding: EdgeInsets.only(bottom: 10.0),
  //                       child: Text(
  //                         'Last Name',
  //                         style: TextStyle(
  //                           fontSize: 22,
  //                           fontWeight: FontWeight.bold,
  //                           color: ColorThemes.colorBlue,
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(bottom: 10.0),
  //                       child: Text(
  //                         " :",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                           fontSize: 18,
  //                           color: ColorThemes.colorBlue,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Padding(
  //                         padding: EdgeInsets.only(bottom: 15.0, left: 15),
  //                         child: TextFormField(
  //                           controller: lastNameController,
  //                           validator: (value) {
  //                             if (value == null) {
  //                               return 'Please Enter a Name';
  //                             }
  //                             if (value.isEmpty) {
  //                               return 'Please Enter a Name';
  //                             }
  //                             if (!regexName.hasMatch(value)) {
  //                               return 'Please Enter a Valid Name';
  //                             }
  //                           },
  //                           decoration: InputDecoration(
  //                               contentPadding: EdgeInsets.only(left: 10.0),
  //                               errorStyle: TextStyle(
  //                                 color: Colors.redAccent,
  //                                 fontSize: 15.0,
  //                               ),
  //                               hintText: user!.lastName,
  //                               focusedBorder: UnderlineInputBorder()),
  //                         ),
  //                       ),
  //                     ),
  //                   ]),
  //                   Row(children: <Widget>[
  //                     Padding(
  //                       padding: EdgeInsets.only(bottom: 10.0),
  //                       child: Text(
  //                         'Email',
  //                         style: TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.bold,
  //                             color: ColorThemes.colorBlue),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(bottom: 10.0),
  //                       child: Text(
  //                         " :",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                           fontSize: 18,
  //                           color: ColorThemes.colorBlue,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                         child: Padding(
  //                             padding: EdgeInsets.only(bottom: 15.0, left: 15),
  //                             child: TextFormField(
  //                                 controller: emailController,
  //                                 validator: (value) {
  //                                   if (value == null) {
  //                                     return 'Please a Email Address';
  //                                   }
  //                                   if (value.isEmpty) {
  //                                     return 'Please a Email Address';
  //                                   }
  //                                   if (!regexName.hasMatch(value)) {
  //                                     return 'Please Enter a Valid Email';
  //                                   }
  //                                 },
  //                                 decoration: InputDecoration(
  //                                     contentPadding:
  //                                         EdgeInsets.only(left: 10.0),
  //                                     errorStyle: TextStyle(
  //                                       color: Colors.redAccent,
  //                                       fontSize: 15.0,
  //                                     ),
  //                                     hintText: user!.email,
  //                                     focusedBorder: UnderlineInputBorder())))),
  //                   ]),
  //                 ],
  //               ),
  //             )
  //           ]),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: isEdit == false
              ? Text('User Profile')
              : Text('Edit User Profile'),
          backgroundColor: ColorThemes.colorOrange,
          foregroundColor: ColorThemes.colorWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          actions: [
            isEdit == false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isEdit = true;
                        print(isEdit);
                      });
                    },
                    icon: Icon(Icons.edit),
                  )
                : IconButton(
                    onPressed: () {
                      toUpdateProfile();
                    },
                    icon: Icon(Icons.done),
                  )
          ],
        ),
        body: user == null
            ? CircularProgressIndicator()
            : isEdit == false
                ? ViewUserProfile(
                    userId: user!.userId,
                  )
                : EditUserProfile(
                    userId: user!.userId,
                  ));
  }

  void toHomePage(BuildContext context) {
    Navigator.of(context).pop(context);
  }

  void toUpdateProfile() async {
    try {
      var data = {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text
      };

      await FirebaseRefs.dbRef
          .child(FirebaseRefs.getMyAccountInfoRef)
          .update(data);
      print("Profile Updated");

      const snackBar = SnackBar(
        content: Text('Profile Updated Successfully'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isEdit = false;
      });
      // Navigator.of(context).pop();
    } catch (err) {
      print(err);
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Failed to Update Profile'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

Widget getImageAsset() {
  AssetImage assetImage = AssetImage('images/avater.jpg');
  Image image = Image(
    image: assetImage,
  );
  return Container(
    child: image,
  );
}



/*

wudget view

widget form


build method
   
   /glk


   kn
     user==null? loadibf widget:
     isEdit==true form : view 




*/
