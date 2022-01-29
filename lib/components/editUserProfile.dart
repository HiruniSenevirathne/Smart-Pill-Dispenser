import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:Smart_Pill_Dispenser_App/components/getImageBuilder.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:Smart_Pill_Dispenser_App/utils/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditUserProfile extends StatefulWidget {
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;

  const EditUserProfile(
      {Key? key,
      required this.userId,
      required this.firstName,
      required this.lastName,
      required this.email})
      : super(key: key);
  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  File? _imageFile;
  PickedFile? pickedImage;
  final picker = ImagePicker();
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
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    String imgeDbRef = FirebaseRefs.getMyAccountInfoRef;
    Query imageRef = FirebaseRefs.dbRef.child(imgeDbRef);
    print(imgeDbRef);

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
                                                hintText: widget.firstName,
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
                                              hintText: widget.lastName,
                                              focusedBorder:
                                                  UnderlineInputBorder()),
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
                                            padding: EdgeInsets.only(
                                                bottom: 15.0, left: 15),
                                            child: TextFormField(
                                                controller: emailController,
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please a Email Address';
                                                  }
                                                  if (value.isEmpty) {
                                                    return 'Please a Email Address';
                                                  }
                                                  if (!regexName
                                                      .hasMatch(value)) {
                                                    return 'Please Enter a Valid Email';
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10.0),
                                                    errorStyle: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 15.0,
                                                    ),
                                                    hintText: widget.email,
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
      const snackBar = SnackBar(
        content: Text('Profile Picture Uploading is Unsuccessful!!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}
