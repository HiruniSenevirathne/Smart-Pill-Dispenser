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

  @override
  Widget build(BuildContext context) {
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
                    firstName: user!.firstName,
                    lastName: user!.lastName,
                    email: user!.email,
                  )
                : EditUserProfile(
                    userId: user!.userId,
                    firstName: user!.firstName,
                    lastName: user!.lastName,
                    email: user!.email,
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
