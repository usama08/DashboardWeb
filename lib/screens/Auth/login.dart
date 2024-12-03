import 'package:dashboarweb/screens/Auth/adminlogin.dart';
import 'package:dashboarweb/screens/Auth/controller/authcontroller.dart';
import 'package:dashboarweb/screens/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;

  // Use the AuthController instance
  final authcontroller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // Call the function to load companies
    authcontroller.getCompany();
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

                  // Wrap Dropdown with Obx to observe changes in the company list
                  Obx(() {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          isExpanded: true,
                          value: authcontroller.selectedCompanyId,
                          hint: Text("Select a company"),
                          items: authcontroller.company
                              .map<DropdownMenuItem<int>>((companyItem) {
                            return DropdownMenuItem<int>(
                              value: companyItem['id'],
                              child: Text(companyItem['company']),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              authcontroller.selectedCompanyId = newValue;
                              authcontroller.selectedCompany =
                                  authcontroller.company.firstWhere((item) =>
                                      item['id'] == newValue)['company'];
                            });
                          },
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 20),

                  // Cooperative Form
                  if (authcontroller.selectedCompanyId != null &&
                      authcontroller.selectedCompany == 'cooperative') ...[
                    _buildTextField(
                        'Portal Username', authcontroller.portalUsername),
                    SizedBox(height: 20),
                    _buildPasswordField(
                        'Portal Password', authcontroller.portalPassword),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        authcontroller.loginCooperative(context);
                      },
                      child: Text('Login as Cooperative'),
                    ),
                  ],

                  // Individual Form
                  if (authcontroller.selectedCompanyId != null &&
                      authcontroller.selectedCompany == 'individual') ...[
                    _buildTextField('Enter Phone', authcontroller.coPhone),
                    SizedBox(height: 20),
                    _buildPasswordField(
                        'Enter Password', authcontroller.portalPassword),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        authcontroller.loginIndividual();
                      },
                      child: Text('Login as Individual'),
                    ),
                  ],

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
                    builder: (context) => AdminLogin(),
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
