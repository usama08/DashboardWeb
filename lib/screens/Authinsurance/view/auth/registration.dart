import 'dart:convert';
import 'package:dashboarweb/screens/Auth/login.dart';
import 'package:fancy_button_new/fancy_button_new.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // To generate random secure key
import 'package:http/http.dart' as http;

import '../../../../services/Api/allApies.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers for Individual form
  final TextEditingController portalUsername = TextEditingController();
  final TextEditingController portalPassword = TextEditingController();
  final TextEditingController cnic = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  // Controllers for Cooperative form
  final TextEditingController coName = TextEditingController();
  final TextEditingController coPhone = TextEditingController();
  final TextEditingController coLandline = TextEditingController();
  final TextEditingController coEmail = TextEditingController();
  final TextEditingController coAddress = TextEditingController();
  final TextEditingController coPassword = TextEditingController();
  final TextEditingController coConfirmPassword = TextEditingController();
  DateTime? selectedDOB;
  String selectedGender = 'Select Gender';
  String selectedForm = 'Individual';
  bool _obscureText = true;
  String secureKey = "";
  List<Map<String, dynamic>> company = [];
  int? selectedCompanyId;
  String selectedCompany = '';

  @override
  void initState() {
    super.initState();
    getCompany();
    secureKey = _generateSecureKey();
  }

  //--------------- Function to generate a random secure key

  String _generateSecureKey() {
    final random = Random();
    const length = 16;
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join('');
  }

  //---------------- Function Api for Get company //

  Future<void> getCompany() async {
    var url = Uri.parse('http://127.0.0.1:3000/companies');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      setState(() {
        // Map each brand to an object with id and brand name
        company = data.map<Map<String, dynamic>>((item) {
          return {'id': item['id'], 'company': item['company']};
        }).toList();
      });
      print('Data fetched: ${response.body}');
    } else {
      print('Failed to fetch data');
    }
  }

  ///----------- Function to register form Api's

  Future<void> register() async {
    var url = Uri.parse(ApiURls.registeruser);

    var body = jsonEncode({
      'portalUsername': portalUsername.text,
      'password': portalPassword.text,
      'cnic': cnic.text,
      'fullName': fullName.text,
      'phone': coPhone.text,
      'landline': coLandline.text,
      'email': coEmail.text,
      'dob': selectedDOB.toString(),
      'address': coAddress.text,
      'gender': selectedGender.toString() == "Select Gender"
          ? "N/A"
          : selectedGender.toString(),
      'companyName': selectedCompany.toString(),
      'companyID': selectedCompanyId,
    });

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var message = jsonResponse['message'] ?? 'Registration successful';
        clear();
        print('Success: $message');
      } else if (response.statusCode == 409) {
        var jsonResponse = jsonDecode(response.body);
        var errorMessage = jsonResponse['error'] ?? 'Duplicate entry';
        print('Failed: $errorMessage');
      } else {
        print('Failed to register user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  Future<void> performRegistration() async {
    try {
      // Step 1: Call getCompany API
      await getCompany();

      // Step 2: Call register API only if getCompany is successful
      await register();

      print('Registration process completed successfully.');
    } catch (e) {
      print('Error during registration process: $e');
    }
  }

  void clear() {
    setState(() {
      portalUsername.clear();
      portalPassword.clear();
      cnic.clear();
      fullName.clear();
      selectedGender = 'Select Gender';

      // Controllers for Cooperative form
      coName.clear();
      coPhone.clear();
      coLandline.clear();
      coEmail.clear();
      coAddress.clear();
      coPassword.clear();
      coConfirmPassword.clear();
      selectedDOB == 'Select Date';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: constraints.maxWidth < 600 ? double.infinity : 500,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedCompanyId != null &&
                              company.firstWhere((item) =>
                                      item['id'] ==
                                      selectedCompanyId)['company'] ==
                                  'cooperative'
                          ? 'Registration (Cooperative)'
                          : 'Registration (Individual)',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          isExpanded: true,
                          value: selectedCompanyId,
                          hint: Text("Select a company"),
                          items:
                              company.map<DropdownMenuItem<int>>((companyItem) {
                            return DropdownMenuItem<int>(
                              value: companyItem['id'],
                              child: Text(companyItem['company']),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedCompanyId = newValue;

                              selectedCompany = company.firstWhere(
                                  (item) => item['id'] == newValue)['company'];
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Cooperative form fields
                    if (selectedCompanyId != null &&
                        company.firstWhere((item) =>
                                item['id'] == selectedCompanyId)['company'] ==
                            'cooperative') ...[
                      _buildTextField('Portal Username', portalUsername),
                      SizedBox(height: 20),
                      _buildPasswordField('Portal Password', portalPassword),
                      SizedBox(height: 20),
                      _buildTextField('CNIC', cnic),
                      SizedBox(height: 20),
                      _buildTextField('Full Name', fullName),
                      SizedBox(height: 20),
                      Text('Secure Key (generated): $secureKey',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],

                    // Individual form fields
                    if (selectedCompanyId != null &&
                        company.firstWhere((item) =>
                                item['id'] == selectedCompanyId)['company'] ==
                            'individual') ...[
                      _buildTextField('Name', fullName),
                      SizedBox(height: 20),
                      _buildTextField('Phone', coPhone),
                      SizedBox(height: 20),
                      _buildTextField('Landline (optional)', coLandline),
                      SizedBox(height: 20),
                      _buildTextField('Email', coEmail),
                      SizedBox(height: 20),
                      _buildTextField('CNIC', cnic),
                      SizedBox(height: 20),
                      _buildDatePicker(context, 'Date of Birth', selectedDOB),
                      SizedBox(height: 20),
                      _buildTextField('Address (optional)', coAddress),
                      SizedBox(height: 20),

                      // Gender selection
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedGender,
                            items: <String>[
                              'Select Gender',
                              'Male',
                              'Female',
                              'Other'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Password and Confirm Password fields
                      _buildPasswordField('Password', portalPassword),
                      SizedBox(height: 20),
                      _buildPasswordField(
                          'Confirm Password', coConfirmPassword),
                    ],

                    SizedBox(height: 20),
                    MyFancyButton(
                      width: 240,
                      borderRadius: 10,
                      isIconButton: false,
                      fontSize: 15,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                      shadowColor: Colors.greenAccent.withOpacity(0.25),
                      text: "Register",
                      tap: () {
                        register();
                      },
                      fontColor: Colors.white,
                      buttonColor: Colors.green,
                      hasShadow: true,
                    ),
                    SizedBox(height: 30),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text("Already have an account? Login",
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to build text fields
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

  // Helper method to build password fields
  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }

  // Helper method to build date picker
  Widget _buildDatePicker(
      BuildContext context, String label, DateTime? selectedDate) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          setState(() {
            selectedDOB = pickedDate;
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          selectedDate != null
              ? "${selectedDate.toLocal()}".split(' ')[0]
              : 'Select Date',
        ),
      ),
    );
  }
}
