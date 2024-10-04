import 'package:dashboarweb/screens/Auth/signup.dart';
import 'package:dashboarweb/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_images.dart';
import '../../packages/alert.dart';
import '../main/main_screen.dart';
import '../profile/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('User Logged In: ${userCredential.user?.email}');
      CustomToast.show(
        context,
        backgroundColor: Colors.green,
        shadhowColor: Colors.green.withOpacity(0.5),
        image: Image.asset(mark),
        message: "Login Successfull",
        textStyle: const TextStyle(color: Colors.black),
        position: ToastPosition.right,
      );
      Get.to(() => MainScreen()); // Navigation with GetX

      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => MainScreen()),
      // );
    } catch (e) {
      print('Login Error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: constraints.maxWidth < 600 ? double.infinity : 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Login',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Email', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text("Don't have an account? Sign up",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
