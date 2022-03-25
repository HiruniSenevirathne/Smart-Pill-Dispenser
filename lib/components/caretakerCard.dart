import 'package:Smart_Pill_Dispenser_App/components/getImageAsset.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/UserInfo.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CaretakerCard extends StatefulWidget {
  final String caretakerId;

  const CaretakerCard({Key? key, required this.caretakerId}) : super(key: key);
  @override
  State<CaretakerCard> createState() => _CaretakerCardState();
}

class _CaretakerCardState extends State<CaretakerCard> {
  UserInfo? caretaker;
  bool isLoading = true;

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/avater.png');
    Image image = Image(
      image: assetImage,
    );
    return Container(
      child: image,
    );
  }

  @override
  void initState() {
    super.initState();
    loadCaretakerInfo();
  }

  void loadCaretakerInfo() async {
    try {
      String ref = FirebaseRefs.getUserInfoRef(widget.caretakerId);
      Query caretakerRef = FirebaseRefs.dbRef.child(ref);

      DataSnapshot event = await caretakerRef.get();
      Map<dynamic, dynamic> result = event.value as Map;
      print(result);
      caretaker = UserInfo.fromJson(result);
      isLoading = false;
      setState(() {});
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Can\'t Load Profile Information",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20, bottom: 10),
        child: Row(children: <Widget>[
          SizedBox(
            width: 75.0,
            height: 75.0,
            child: toGetCaretakerImage(),
          ),
          SizedBox(width: 20, height: 5),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                isLoading || caretaker == null
                    ? CircularProgressIndicator()
                    : Text(
                        caretaker!.firstName + " " + caretaker!.lastName,
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorThemes.colorBlue,
                            fontWeight: FontWeight.bold),
                      ),
              ]),
        ]));
  }

  Widget toGetCaretakerImage() {
    toGetImage() async {
      String imgeDbRef = FirebaseRefs.getAccountImageIdRef(widget.caretakerId);
      Query imageRef = FirebaseRefs.dbRef.child(imgeDbRef);
      print(imgeDbRef);
      DataSnapshot event = await imageRef.get();
      print(event.value);
      final ref = FirebaseStorage.instance.ref().child(event.value.toString());
      var url = await ref.getDownloadURL();
      print(url);
      return url;
    }

    return FutureBuilder<String>(
        future: toGetImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: CachedNetworkImage(
                imageUrl: snapshot.data.toString(),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 90,
                ),
              ),
            );
          }
          return GetImageAsset();
        });
  }
}
