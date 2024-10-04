import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboarweb/screens/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // Fetch user information from Firestore
  Future<Map<String, dynamic>?> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      print('userid${user.uid}');
      return doc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: currentUser == null
            ? Center(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                        // Navigate to the SignUp screen
                      },
                      child: const Text("Register Now"),
                    ),
                  ],
                ),
              )
            : FutureBuilder<Map<String, dynamic>?>(
                future: getUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data != null) {
                    var userInfo = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  AssetImage('assets/profile_avatar.png'),
                            ),
                            const SizedBox(width: 20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userInfo['fullname'] ?? 'Name not available',
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
                        Row(
                          children: [
                            const Icon(Icons.phone, color: Colors.blue),
                            const SizedBox(width: 10.0),
                            Text(
                              userInfo['phone'] ?? 'Phone not available',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            const Icon(Icons.email, color: Colors.blue),
                            const SizedBox(width: 10.0),
                            Text(
                              userInfo['email'] ?? 'Email not available',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Failed to load user information.",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
