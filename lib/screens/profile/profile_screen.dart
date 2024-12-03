import 'package:dashboarweb/screens/Auth/controller/authcontroller.dart';
import 'package:dashboarweb/screens/Auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var authcontroller = Get.put(AuthController());
  bool type = false;
  // Controller to handle text field input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int? phonenumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Checking if userData is empty
          if (authcontroller.userData.value == null ||
              authcontroller.userData.value!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "You are not registered!",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => SignUpScreen());
                    },
                    child: const Text("Register Now"),
                  ),
                ],
              ),
            );
          } else {
            // Data is available
            var userInfo = authcontroller.userData.value!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display user name
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/profile_avatar.png'),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userInfo['FullName'] ?? 'Name not available',
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'User',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),

                // Editable Phone
                GestureDetector(
                  onTap: () => textEdi(
                    context,
                    'Phone',
                    userInfo['Phone'],
                    phonenumber,
                    () {
                      authcontroller.profileUpdate(
                          context: context,
                          userID: authcontroller.userData.value['UserID'],
                          email: emailController.text,
                          password: passwordController.text,
                          phone: phonenumber);
                    },
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.blue),
                      const SizedBox(width: 10.0),
                      Text(
                        userInfo['Phone'].toString() ?? 'Phone not available',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const Spacer(),
                      const Icon(Icons.edit, color: Colors.grey),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),

                // Editable Email
                GestureDetector(
                  onTap: () => _showEditDialog(
                    context,
                    'Email',
                    userInfo['Email'].toString(),
                    emailController,
                    () {
                      // Call the update function for email
                      authcontroller.profileUpdate(
                          context: context,
                          userID: authcontroller.userData.value['UserID'],
                          email: emailController.text,
                          password: passwordController.text,
                          phone: phonenumber);
                    },
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.email, color: Colors.blue),
                      const SizedBox(width: 10.0),
                      Text(
                        userInfo['Email'] ?? 'Email not available',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const Spacer(),
                      const Icon(Icons.edit, color: Colors.grey),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),

                // Editable Password
                GestureDetector(
                  onTap: () => _showEditDialog(
                    context,
                    'Password',
                    '********',
                    passwordController,
                    () {
                      authcontroller.profileUpdate(
                          context: context,
                          userID: authcontroller.userData.value['UserID'],
                          email: emailController.text,
                          password: passwordController.text,
                          phone: phonenumber);
                    },
                    isPassword: true,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lock, color: Colors.blue),
                      const SizedBox(width: 10.0),
                      const Text(
                        'Change Password',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const Spacer(),
                      const Icon(Icons.edit, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  // Function to display an edit dialog
  void _showEditDialog(BuildContext context, String field, String currentValue,
      TextEditingController controller, VoidCallback onSave,
      {bool isPassword = false}) {
    controller.text = currentValue;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              labelText: 'Enter new $field',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave();
                Get.back(); // Close dialog after saving
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void textEdi(BuildContext context, String field, String currentValue,
      var controller, VoidCallback onSave,
      {bool isPassword = false}) {
    controller = currentValue;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              labelText: 'Enter new $field',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave();

                Get.back(); // Close dialog after saving
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
