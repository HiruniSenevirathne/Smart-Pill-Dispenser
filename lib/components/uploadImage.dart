import 'dart:io';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart';
import 'package:Smart_Pill_Dispenser_App/utils/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File? _imageFile;
  PickedFile? pickedImage;
  UserInfo? user;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
      print("--------------");
      print(_imageFile);
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
        Navigator.pop(context);
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
      //image uploaded snackbar
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white24,
        foregroundColor: Colors.blue,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
                              ? Image.file(_imageFile!)
                              : TextButton(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                  ),
                                  onPressed: pickImage,
                                ),
                        ),
                      ),
                    ),
                  ],
                )),
                uploadImageButton(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 100.0),
            child: TextButton(
              onPressed: () {
                updateUserProfilePic();
              },
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
