import 'package:dashboarweb/screens/Auth/adminlogin.dart';
import 'package:dashboarweb/screens/Auth/controller/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authcontroller = Get.put(AuthController());

  // Colors (replace with your color definition)
  final Color blue = Colors.blue;
// Admin Register API function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: constraints.maxWidth < 600 ? double.infinity : 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Admin Sign Up',
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextField(
                  controller: authcontroller.name,
                  decoration: InputDecoration(
                      labelText: 'Full Name', border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: authcontroller.email,
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: authcontroller.password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Call the register function when the button is pressed
                    authcontroller.adminRegister();
                  },
                  child: Text('Sign Up'),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navigate to Login Screen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminLogin()));
                  },
                  child: Text("Admin? Login",
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
