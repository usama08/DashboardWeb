import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboarweb/screens/Auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../packages/alert.dart'; // Replace with your snack bar implementation

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  // Colors (replace with your color definition)
  final Color blue = Colors.blue;

  Future<dynamic> registerEmailPassword(context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());
      if (userCredential.user != null) {
        // Save user details in Firestore
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user!.uid) // Use UID as document ID
            .set({
          "userId": userCredential.user!.uid,
          "fullname": name.text.trim(),
          "email": email.text.trim(),
        });
      
        // Show a loading dialog (optional)
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2,
              ),
            );
          },
        );

        // Wait for 3 seconds
        await Future.delayed(const Duration(seconds: 3));

        // Navigate to the login screen

        // Alternatively, you can use:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase errors (like invalid email, weak password)
      CustomToast.show(
        context,
        backgroundColor: Colors.white,
        shadhowColor: Colors.green.withOpacity(0.5),
        image: Image.asset(mark),
        message: "Something Wrong!",
        textStyle: const TextStyle(color: Colors.black),
        position: ToastPosition.top,
      );

      return false;
    } catch (e) {
      // Handle other errors
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign Up',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: 'Full Name', border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextField(
                controller: email,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call the register function when the button is pressed
                  registerEmailPassword(context);
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to Login Screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text("Already have an account? Login",
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
