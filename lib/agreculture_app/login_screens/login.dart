import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'forgotpassword.dart';
import 'signup.dart';
import 'wrapper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool light = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool? isEmailValid; // Track email validation
  bool ispassValid = false; // Track email validation

  // Function to handle sign-in
  void signin(BuildContext context) async {
    if (email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter email and password.'),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Navigate to Wrapper after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Wrapper()), // Replace Wrapper() with your actual Wrapper widget
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in. Please check your credentials.'),
        ),
      );
    }
  }

  // Login with google
  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged in successfully with Google'),
        ),
      );

      // Redirect to MyHomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      );
    } catch (e) {
      // Handle sign-in errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 40),
            Image.asset(
              'assets/images/login/logo.png',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            "Sign in to Continue",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 40),
        Container(
          margin: EdgeInsets.only(bottom: 10),
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
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF595959)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: (() {
                  switch (isEmailValid) {
                    case true:
                      return Color(0xFF779D07);
                    case false:
                      return Colors.red;
                    default:
                      return isEmailValid == null
                          ? Colors.grey
                          : Color.fromARGB(255, 124, 124, 124);
                  }
                })(),
              ),
            ),
            filled: false,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            prefixIcon: Icon(
              Icons.email,
              color: (() {
                switch (isEmailValid) {
                  case true:
                    return Color(0xFF779D07);
                  case false:
                    return Colors.red;
                  default:
                    return isEmailValid == null
                        ? Colors.grey
                        : Color.fromARGB(255, 119, 119, 119);
                }
              })(),
            ),
          ),
          onChanged: (value) {
            setState(() {
              // Validate email format on each change
              isEmailValid =
                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              setState(() {
                isEmailValid = false;
              });
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              setState(() {
                isEmailValid = false;
              });
              return 'Please enter a valid email';
            }
            setState(() {
              isEmailValid = true;
            });
            return null;
          },
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(bottom: 10),
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
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ispassValid ? Color(0xFF779D07) : Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF779D07)),
            ),
            filled: false,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            prefixIcon: Icon(
              Icons.lock,
              color: ispassValid ? Color(0xFF779D07) : Colors.grey,
            ),
          ),
          onChanged: (value) {
            setState(() {
              ispassValid = value.isNotEmpty;
            });
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            ispassValid = true;
            return null;
          },
          obscureText: true,
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.scale(
              scale: 0.8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                margin: EdgeInsets.only(left: 0),
                child: Switch(
                  value: light,
                  activeColor: Color(0xFF779D07),
                  onChanged: (bool value) {
                    setState(() {
                      light = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
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
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () => signin(context),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            side: BorderSide(color: Color(0xFF779D07)),
            backgroundColor: Color(0xFF779D07),
          ),
          child: const Text(
            'Login',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Login with Google',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () => loginWithGoogle(context),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            side: BorderSide(color: Color(0xFF779D07)),
          ),
          child: const Text(
            'Login with Google',
            style: TextStyle(color: Color(0xFF779D07)),
          ),
        ),
      ],
    );
  }

  Widget _signup(context) {
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
          ),
        ),
      ],
    );
  }
}
