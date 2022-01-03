import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRefs {
  static final DatabaseReference dbRef = FirebaseDatabase.instanceFor(
          app: Firebase.apps.first,
          databaseURL:
              "https://smartpilldispenser-8714f-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref();
  static String get getCaretakerInfoRef {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String CaretakerInfo = "/caretakers/${uid}/info";
    return CaretakerInfo;
  }
}
