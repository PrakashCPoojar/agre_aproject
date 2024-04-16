import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  bool emailFocus = false;
  bool? isEmailValid; // Track email validation

  void reset(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password reset email sent successfully!'),
            duration: Duration(seconds: 3),
          ),
        );
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send password reset email.'),
          ),
        );
      }
    }
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/login/logo.png',
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
                    'Please enter your email where you’d like to get the password reset link',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Color(0xFF595959)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
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
                        isEmailValid = true; // Reset validation state on change
                      });
                    },
                    onTap: () {
                      setState(() {
                        isEmailValid = true;
                      });
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        emailFocus = false;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          isEmailValid = false;
                        });
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
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
                ),
                SizedBox(height: 80),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () => reset(context),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: Size(double.infinity, 2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
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
        ),
      ),
    );
  }
}
