import 'package:agre_aproject/agreculture_app/home.dart';
import 'package:agre_aproject/agreculture_app/screens/login.dart';
import 'package:agre_aproject/agreculture_app/screens/termsandcondition.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class signup extends StatelessWidget {
  const signup({Key? key}) : super(key: key);

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
                        decoration: InputDecoration(
                          hintText: "Enter your full name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(color: Color(0xFF595959)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // Set focused border
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .primaryColor), // Use primary color
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
                      child: Text('Phone Number'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter your phone number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(color: Color(0xFF595959)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // Set focused border
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .primaryColor), // Use primary color
                          ),
                          filled: false,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8), // Adjust input height here
                          prefixIcon: const Icon(Icons.phone),
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
                        decoration: InputDecoration(
                          hintText: "Enter your new password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(color: Color(0xFF595959)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // Set focused border
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .primaryColor), // Use primary color
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          },
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
    );
  }
}
