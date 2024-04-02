import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '1. Introduction',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'These terms and conditions outline the rules and regulations for the use of our agriculture app, including its features, services, and content.',
            ),
            SizedBox(height: 20.0),
            Text(
              '2. Acceptance of Terms',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'By accessing or using our app, you agree to be bound by these terms and conditions. If you disagree with any part of these terms and conditions, you must not use our app.',
            ),
            SizedBox(height: 20.0),
            Text(
              '3. User Accounts',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'You must be at least 18 years of age to create an account on our app. When creating an account, you agree to provide accurate and complete information.',
            ),
            // Add more sections as needed...
          ],
        ),
      ),
    );
  }
}
