import 'package:agre_aproject/agreculture_app/login_screens/resetpassword.dart';
import 'package:flutter/material.dart';

class otpsection extends StatelessWidget {
  const otpsection({Key? key}) : super(key: key);

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
                    SizedBox(height: 40),
                    Text(
                      'Enter your OTP',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Please enter 4 digit verification code sent to your registered mobile number',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 48,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: TextField(
                              textAlign: TextAlign
                                  .center, // Align the text center inside the input
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: TextStyle(
                                  fontSize: 32,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // Set focused border
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .primaryColor), // Use primary color
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Color(0xFF595959)),
                                ),
                                filled: false,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                // Remove prefixIcon
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                10), // Adjust the horizontal spacing between inputs
                        SizedBox(
                          width: 48,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: TextField(
                              textAlign: TextAlign
                                  .center, // Align the text center inside the input
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: TextStyle(
                                  fontSize: 32,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // Set focused border
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .primaryColor), // Use primary color
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Color(0xFF595959)),
                                ),
                                filled: false,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                // Remove prefixIcon
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                10), // Adjust the horizontal spacing between inputs
                        SizedBox(
                          width: 48,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: TextField(
                              textAlign: TextAlign
                                  .center, // Align the text center inside the input
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: TextStyle(
                                  fontSize: 32,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // Set focused border
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .primaryColor), // Use primary color
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Color(0xFF595959)),
                                ),
                                filled: false,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                // Remove prefixIcon
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                10), // Adjust the horizontal spacing between inputs
                        SizedBox(
                          width: 48,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: TextField(
                              textAlign: TextAlign
                                  .center, // Align the text center inside the input
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: TextStyle(
                                  fontSize: 32,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // Set focused border
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .primaryColor), // Use primary color
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Color(0xFF595959)),
                                ),
                                filled: false,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                // Remove prefixIcon
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Resend OTP in',
                      style: TextStyle(
                        fontSize: 12,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 118), // Add margin top and bottom
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => resetpassword()),
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
