import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MylogIn extends StatefulWidget {
  const MylogIn({Key? key}) : super(key: key);

  @override
  State<MylogIn> createState() => _MylogInState();
}

class _MylogInState extends State<MylogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> insertData() async {
    var url = Uri.parse('http://127.0.0.1:3000/insert');
    var response = await http.post(
      url,
      body: jsonEncode({
        'email': emailController.text,
        'password':
            passwordController.text, // Fixed typo from 'paswsord' to 'password'
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print('enail${emailController.text}');
    if (response.statusCode == 200) {
      print('Data inserted successfully');
    } else {
      print('Failed to insert data: ${response.body}');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter with MySQL'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              insertData();
            },
            child: const Text('Insert Data'),
          ),
        ],
      ),
    );
  }
}
