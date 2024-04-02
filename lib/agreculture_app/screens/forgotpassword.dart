import 'package:agre_aproject/agreculture_app/screens/otp.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
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
                    SizedBox(height: 40),
                    Text(
                      'Forgot your password?',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Please enter your phone number where you’d like to get the OTP',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 72),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "+91 xxxxxxxxxx",
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
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 72), // Add margin top and bottom
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => otpsection()),
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
