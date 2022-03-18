import 'package:Smart_Pill_Dispenser_App/screens/loadingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

// import './loginScreen.dart';
FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await Firebase.initializeApp(
  //   name: "rtdb",
  //   options: FirebaseOptions(
  //       apiKey: "AIzaSyCLkPeVVhYOZMOCmcoHz0RNc8tdFMJHWfM",
  //       appId: "1:303356559882:android:9bb94202c9e6dbbb3b55f3",
  //       messagingSenderId: "303356559882",
  //       projectId: "smartpilldispenser-8714f",
  //       databaseURL:
  //           "https://smartpilldispenser-8714f-default-rtdb.asia-southeast1.firebasedatabase.app"),
  // );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Smart Pill Dispenser App',
    // home: PatientScheduleScreen(),
    // home: PatientHomeScreen(),
    // home: PatientLoginScreen(),
    // home: CaretakerEditScheduleScreen(),
    // home: CaretakerAddScheduleScreen(),
    // home: CaretakerViewScheduleScreen(),
    // home: CaretakerViewPatientScreen(),
    // home: CaretakerPatientPasswordRecivingScreen(),
    // home: RegisterPatientScreen(),
    // home: CaretakerPatientListScreen(),
    // home: CaretakerHomeScreen(),
    // home: CaretakerSignupScreenIII(),
    // home: StarterScreen(),
    // home: SignupScreen(),
    // home: CaretakerLoginScreen(),
    // home: UploadingImageToFirebaseStorage(),
    home: LoadingScreen(),
  ));
}
