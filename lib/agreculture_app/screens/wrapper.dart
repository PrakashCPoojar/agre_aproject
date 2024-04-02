import 'package:agre_aproject/agreculture_app/home.dart';
import 'package:agre_aproject/agreculture_app/screens/login.dart';
// import 'package:agre_aproject/agreculture_app/screens/login.dart';
// import 'package:agre_aproject/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
