import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRefs {
  static final DatabaseReference dbRef = FirebaseDatabase.instanceFor(
          app: Firebase.apps.first,
          databaseURL:
              "https://smartpilldispenser-8714f-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref();

  static String get getMyAccountInfoRef {
    String uId = FirebaseAuth.instance.currentUser!.uid;
    String ref = "/users/${uId}/info";
    return ref;
  }

  static String getUserInfoRef(String uid) {
    String ref = "/users/${uid}/info";
    return ref;
  }

  static String getMyAccountImageIdRef() {
    String uId = FirebaseAuth.instance.currentUser!.uid;
    String ref = "/users/${uId}/info/image_id";
    return ref;
  }

  static String get getCaretakerInfoRef {
    String ctId = FirebaseAuth.instance.currentUser!.uid;
    String ref = "/caretakers/${ctId}/info";
    return ref;
  }

  static String get getPatientInfoRef {
    String patientId = FirebaseAuth.instance.currentUser!.uid;
    String ref = "/patients/${patientId}/info";
    return ref;
  }

  static String getNewScheduleItemRef(String patientId) {
    int scheduleItemId = new DateTime.now().millisecondsSinceEpoch;
    String ref = "/patients/${patientId}/schedule/${scheduleItemId}";
    return ref;
  }

  static String getScheduleListRef(String patientId) {
    String ref = "/patients/${patientId}/schedule";
    return ref;
  }

  static String getScheduleItemRef(String patientId, String scheduleItemId) {
    String ref = "/patients/${patientId}/schedule/${scheduleItemId}";
    return ref;
  }

  static String get getCaretakerPatientsRef {
    String ctId = FirebaseAuth.instance.currentUser!.uid;
    String ref = "/caretakers/${ctId}/patients";
    return ref;
  }
}
