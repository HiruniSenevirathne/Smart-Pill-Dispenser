import 'dart:io';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/utils/Utils.dart';
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
  bool _load = false;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
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
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Uploading Image to Firebase Storage",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                    child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
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
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
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
