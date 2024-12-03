import 'package:dashboarweb/screens/Auth/controller/authcontroller.dart';
import 'package:dashboarweb/screens/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final auth = FirebaseAuth.instance;

  // Use the AuthController instance
  final authcontroller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // Call the function to load companies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.admin_panel_settings),
            onPressed: () {
              showAdminDialog(context);
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: constraints.maxWidth < 600 ? double.infinity : 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),

                  // Cooperative Form

                  _buildTextField('Admin Username', authcontroller.adminname),
                  SizedBox(height: 20),
                  _buildPasswordField(
                      'Admin Password', authcontroller.adminpassword),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      authcontroller.adminLogin(context);
                    },
                    child: Text('Admin Login'),
                  ),

                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: authcontroller.obscureText.value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            authcontroller.obscureText.value
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            authcontroller.obscureText.value =
                !authcontroller.obscureText.value;
          },
        ),
      ),
    );
  }

  void showAdminDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Admin Access'),
          content: Text('Admin button pressed.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
