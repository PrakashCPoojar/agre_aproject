import 'package:agre_aproject/agreculture_app/login_screens/forgotpassword.dart';
import 'package:agre_aproject/agreculture_app/login_screens/loginwithemail.dart';
import 'package:agre_aproject/agreculture_app/login_screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // const LoginPage({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Function to handle sign-in
  void signin(BuildContext context) async {
    // Validate if email and password are not empty
    if (email.text.isEmpty || password.text.isEmpty) {
      // Show error message if email or password is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter email and password.'),
        ),
      );
      return; // Stop execution if email or password is empty
    }

    try {
      // Sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      // Navigate to the next screen or perform other actions
    } catch (e) {
      // Handle sign-in errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in. Please check your credentials.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 20), // Add some space between text and image
            Image.asset(
              'assets/images/login/logo.png', // Adjust the path based on your image location
              width: 150, // Adjust width as needed
              height: 150, // Adjust height as needed
              fit: BoxFit.cover, // Adjust how the image fits the space
            ),
            Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF779D07)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    bool light = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 16), // Add margin bottom here
          child: Text(
            "Sign in to Continue",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10), // Add margin bottom here
          child: Text(
            "Email",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: email,
          decoration: InputDecoration(
            hintText: "Enter email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Color(0xFF595959)),
            ),
            filled: false,
            contentPadding:
                EdgeInsets.symmetric(vertical: 8), // Adjust input height here
            prefixIcon: const Icon(Icons.email),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(bottom: 10), // Add margin bottom here
          child: Text(
            "Password",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: password,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Color(0xFF595959)),
            ),
            filled: false,
            contentPadding:
                EdgeInsets.symmetric(vertical: 8), // Adjust input height here
            prefixIcon: const Icon(Icons.lock),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          obscureText: true,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Switch(
              // This bool value toggles the switch.
              value: light,
              activeColor: Color(0xFF779D07),
              onChanged: (bool value) {},
            ),
            Container(
              margin:
                  EdgeInsets.only(left: 8), // Adjust left margin for spacing
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()),
                  );
                },
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Color(0xFF779D07)),
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 2),
        Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 10), // Add margin top and bottom
            child: ElevatedButton(
              onPressed: () => signin(context),
              // child: Text('Login'),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                minimumSize: Size(
                    double.infinity, 2), // Set the minimum size for the button
                padding: const EdgeInsets.symmetric(vertical: 8),
                backgroundColor: Color(0xFF779D07),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'OR',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          child: Container(
            margin:
                EdgeInsets.symmetric(vertical: 20), // Add margin top and bottom
            child: Text(
              'Login with social',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginWithEmailPage()),
              );
            },
            child: const Text(
              'Login with email',
              style: TextStyle(color: Color(0xFF779D07)),
            )),
      ],
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => signup()),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Color(0xFF779D07)),
            ))
      ],
    );
  }
}
