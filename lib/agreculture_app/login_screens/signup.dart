import 'package:agre_aproject/agreculture_app/homecontent.dart';
import 'package:agre_aproject/agreculture_app/login_screens/login.dart';
import 'package:agre_aproject/agreculture_app/login_screens/termsandcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: Get.key, // Provide a key for contextless navigation
      home: signup(),
    );
  }
}

class signup extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _signup(BuildContext context) async {
    // Check if email or password is empty
    if (email.text.isEmpty || password.text.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter email and password.'),
        ),
      );
      return; // Stop execution if email or password is empty
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Update user's display name (full name) if user is not null
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(fullname.text);
      }
      // You may also update custom claims here if needed

      // Signup successful, navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Handle weak password error
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // Handle email already in use error
        print('The account already exists for that email.');
      }
      // Show any other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign up: ${e.message}'),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Forgot Password',
      //     style: TextStyle(
      //       fontSize: 18,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        // Center the image and text
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/login/logo.png', // Adjust the image path
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Text('Full Name'),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: TextField(
                          controller: fullname,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Enter your full name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(color: Color(0xFF595959)),
                            ),
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8), // Adjust input height here
                            prefixIcon:
                                const Icon(Icons.supervised_user_circle_sharp),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Text('Email'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            hintText: "Enter your email number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(color: Color(0xFF595959)),
                            ),
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8), // Adjust input height here
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Text('Password'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                            hintText: "Enter your new password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(color: Color(0xFF595959)),
                            ),
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8), // Adjust input height here
                            prefixIcon: const Icon(Icons.password),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'By signing up, you are agree to our ',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                color: Color(0xFF779D07),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TermsAndConditionsPage()),
                                  ); // Navigate to Terms & Conditions page
                                },
                            ),
                            TextSpan(
                              text: ' and Policies',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 36), // Add margin top and bottom
                          child: ElevatedButton(
                            onPressed: (() => _signup(context)),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              minimumSize: Size(double.infinity,
                                  2), // Set the minimum size for the button
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              backgroundColor: Color(0xFF779D07),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have account ?',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: ' Login',
                                style: TextStyle(
                                  color: Color(0xFF779D07),
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    ); // Navigate to Terms & Conditions page
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
