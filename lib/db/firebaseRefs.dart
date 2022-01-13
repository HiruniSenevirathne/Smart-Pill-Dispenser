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
    String patientId = FirebaseAuth.instance.currentUser!.uid;
    String PatientInfo = "/patients/${patientId}/info";
    return PatientInfo;
  }

  static String get getCaretakersRef {
    return "/caretakers";
  }
  // static void getPatientList() async {
  //   Query queryToGetId = FirebaseRefs.dbRef
  //       .child('/caretakers')
  //       .orderByChild('patients')
  //       .limitToLast(1);
  //   DataSnapshot event = await queryToGetId.get();
  //   Map<dynamic, dynamic> result = event.value as Map;
  //   print(result);
  //   Map<dynamic, dynamic> resultPatient = result.values.first["patients"];
  //   print(resultPatient);
  //   String patientUid = resultPatient.values.first["patient_id"];
  //   print(patientUid);
  //   Query queryToGetName = FirebaseRefs.dbRef
  //       .child('/users')
  //       .orderByChild('user_id')
  //       .equalTo(patientUid);
  //   DataSnapshot event2 = await queryToGetName.get();
  //   Map<dynamic, dynamic> result2 = event2.value as Map;
  //   print(result2);
  //   String resultFirstName = result2.values.first["first_name"];
  //   String resultLastName = result2.values.first["last_name"];
  //   String patientName = resultFirstName + resultLastName;
  //   print(patientName);
  // }
}
