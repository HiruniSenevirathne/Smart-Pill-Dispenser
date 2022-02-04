import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;
import 'package:Smart_Pill_Dispenser_App/components/getImageBuilder.dart';
import 'package:Smart_Pill_Dispenser_App/components/viewUserProfile.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:Smart_Pill_Dispenser_App/utils/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  RegExp regexName = RegExp(r'^[a-zA-z]+([\s])*$');
  bool? isEdit = false;

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
        title:
            isEdit == false ? Text('User Profile') : Text('Edit User Profile'),
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
              : editUserProfile(context),
    );
  }

  File? _imageFile;
  PickedFile? pickedImage;
  final picker = ImagePicker();

  var _formKey = GlobalKey<FormState>();

  Widget editUserProfile(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Query imageRef = FirebaseRefs.dbRef.child(FirebaseRefs.getMyAccountInfoRef);

    return StreamBuilder(
        stream: imageRef.onValue,
        builder: (context, AsyncSnapshot dataSnapshot) {
          return Container(
            margin: EdgeInsets.only(
              left: 25.0,
              right: 10.0,
            ),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: screenHeight / 50),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: SizedBox(
                                          child: GetImageBuilder(),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 80, top: 115),
                                        child: TextButton(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 30,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            pickImage();
                                          },
                                        ),
                                      ),
                                    ),
                                  ]),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 15.0),
                                          child: Text(
                                            'First Name',
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: ColorThemes.colorBlue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 15.0),
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
                                            padding: EdgeInsets.only(
                                                bottom: 15.0, left: 15),
                                            child: TextFormField(
                                              controller: firstNameController,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Please Enter a Name';
                                                }
                                                if (value.isEmpty) {
                                                  return 'Please Enter a Name';
                                                }
                                                if (!regexName
                                                    .hasMatch(value)) {
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
                                                focusedBorder:
                                                    UnderlineInputBorder(),
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
                                        padding: EdgeInsets.only(
                                            bottom: 15.0, left: 15),
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
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.0),
                                              errorStyle: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 15.0,
                                              ),
                                              hintText: user!.lastName,
                                              focusedBorder:
                                                  UnderlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            )),
                      ]),
                ),
              ],
            ),
          );
        });
  }

  Future<String> uploadImageToFirebase(BuildContext context) async {
    String ref = FirebaseRefs.getMyAccountInfoRef;
    Query userRef = FirebaseRefs.dbRef.child(ref);

    DataSnapshot event = await userRef.get();
    Map<dynamic, dynamic> result = event.value as Map;
    print("------------------------");
    print(result);
    user = UserInfo.fromJson(result);
    if (user!.imageId != null) {
      String oldImageDbRef = FirebaseRefs.getMyAccountImageIdRef();
      Query oldImageRef = FirebaseRefs.dbRef.child(oldImageDbRef);
      print(oldImageRef);
      DataSnapshot event = await oldImageRef.get();
      Reference oldRef =
          FirebaseStorage.instance.ref().child(event.value.toString());
      try {
        await oldRef.delete();
        await FirebaseRefs.dbRef
            .child(FirebaseRefs.getMyAccountImageIdRef())
            .remove();
        // Navigator.pop(context);
      } catch (err) {
        print(err);
      }
    }
    String fileExt = path.extension(_imageFile!.path);
    String fileName = AppUtils.genUUIDFileName() + fileExt;
    String filePath = 'uploads/$fileName';
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(filePath);
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask;
    await taskSnapshot.ref.getDownloadURL();
    return filePath;
  }

  updateUserProfilePic() async {
    try {
      String imagePath = await uploadImageToFirebase(context);
      await FirebaseRefs.dbRef
          .child(FirebaseRefs.getMyAccountImageIdRef())
          .set(imagePath);

      Fluttertoast.showToast(
          msg: "Profile Picture Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Profile Picture Not Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      _imageFile = croppedFile;
      print("--------------");
      print(_imageFile);
    });
    updateUserProfilePic();
  }

  void toUpdateProfile() async {
    try {
      var data = {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text
      };

      await FirebaseRefs.dbRef
          .child(FirebaseRefs.getMyAccountInfoRef)
          .update(data);
      print("Profile Updated");
      Fluttertoast.showToast(
          msg: "Profile Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {
        isEdit = false;
      });
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Failed to Update Profile",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void toHomePage(BuildContext context) {
    Navigator.of(context).pop(context);
  }
}

Widget getImageAsset() {
  AssetImage assetImage = AssetImage('images/avater.png');
  Image image = Image(
    image: assetImage,
  );
  return Container(
    child: image,
  );
}
