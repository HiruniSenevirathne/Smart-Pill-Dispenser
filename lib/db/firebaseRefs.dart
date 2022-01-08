import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRefs {
  static final DatabaseReference dbRef = FirebaseDatabase.instanceFor(
          app: Firebase.apps.first,
          databaseURL:
              "https://smartpilldispenser-8714f-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref();

  static String get getUserInfoRef {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String UserInfo = "/users/${uid}/info";
    return UserInfo;
  }

  static String get getCaretakerInfoRef {
    String ct_id = FirebaseAuth.instance.currentUser!.uid;
    String CaretakerInfo = "/caretakers/${ct_id}/info";
    return CaretakerInfo;
  }

  static String get getPatientInfoRef {
    String p_id = FirebaseAuth.instance.currentUser!.uid;
    String PatientInfo = "/patients/${p_id}/info";
    return PatientInfo;
  }
}
