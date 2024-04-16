import 'package:agre_aproject/agreculture_app/login_screens/flash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCpJhHCP9gRPRB0X4y7SOcp-uJh8umheb8",
            authDomain: "agriculture-project-9300-b4362.firebaseapp.com",
            databaseURL:
                "https://agriculture-project-9300-b4362-default-rtdb.firebaseio.com",
            projectId: "agriculture-project-9300-b4362",
            storageBucket: "agriculture-project-9300-b4362.appspot.com",
            messagingSenderId: "490037004411",
            appId: "1:490037004411:web:44f500ad35d45c31203ade"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primaryColor: Color(0xFF779D07),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FlashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
