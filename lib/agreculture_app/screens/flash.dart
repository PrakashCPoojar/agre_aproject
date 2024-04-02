import 'dart:async';
import 'package:agre_aproject/agreculture_app/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define your app's theme
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FlashPage(), // Set GetStarted as the default route
    );
  }
}

class FlashPage extends StatefulWidget {
  @override
  _FlashPageState createState() => _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to Login page after 3 seconds (adjust duration as needed)
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Your existing GetStarted content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Center image
              GestureDetector(
                onTap: () {
                  // Add your action here
                },
                child: Image.asset(
                  'assets/images/home/logo.jpg',
                  width: 180.0,
                ),
              ),
              SizedBox(height: 20.0),
              // Existing content
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 5), // Add spacing between the text parts
                  Column(
                    children: [
                      Text(
                        'Welcome to ',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Farmers Information Hub',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(119, 157, 7, 100),
                        ),
                        maxLines: 1, // Limit to one line
                        overflow:
                            TextOverflow.ellipsis, // Handle overflow gracefully
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: -20.0,
            right: -20.0,
            child: Image.asset(
              'assets/images/home/leaves.png',
              width: 300.0,
            ),
          ),
          Positioned(
            bottom: -25.0,
            left: -25.0,
            child: Transform.rotate(
              angle: 3.1,
              child: Image.asset(
                'assets/images/home/leaves.png',
                width: 300.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
