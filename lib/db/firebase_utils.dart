import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseUtils {
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static void saveFCMToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      await FirebaseRefs.dbRef
          .child(FirebaseRefs.getMyAccountFCMRef)
          .set(token);
    } catch (err) {
      print(["fcm error", err]);
    }
  }
}
