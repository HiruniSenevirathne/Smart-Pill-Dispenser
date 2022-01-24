import 'package:Smart_Pill_Dispenser_App/components/getImageAsset.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class GetImageBuilder extends StatefulWidget {
  @override
  State<GetImageBuilder> createState() => _GetImageBuilderState();
}

class _GetImageBuilderState extends State<GetImageBuilder> {
  @override
  Widget build(BuildContext context) {
    toGetImage() async {
      String imgeDbRef = FirebaseRefs.getMyAccountImageIdRef();
      Query imageRef = FirebaseRefs.dbRef.child(imgeDbRef);
      print(imgeDbRef);
      DataSnapshot event = await imageRef.get();
      print(event.value);
      // Map<dynamic, dynamic> result = event.value as Map;
      // print("------------------------");
      // print(event.value);
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
              //     child: CircleAvatar(
              //   radius: 90,
              //   backgroundImage: NetworkImage(snapshot.data.toString()),
              // ));
            );
          }
          return GetImageAsset();
        });
  }
}
