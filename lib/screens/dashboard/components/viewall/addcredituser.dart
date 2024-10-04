import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreditFormScreen extends StatefulWidget {
  @override
  _CreditFormScreenState createState() => _CreditFormScreenState();
}

class _CreditFormScreenState extends State<CreditFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _creditNameController = TextEditingController();
  final TextEditingController _creditAmountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Automatically generate and set User ID when the form is initialized
    _userIdController.text = _generateRandomUserId();
  }

  @override
  void dispose() {
    _creditNameController.dispose();
    _creditAmountController.dispose();
    _phoneNumberController.dispose();
    _userIdController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Function to generate a random User ID with numbers and alphabets
  String _generateRandomUserId([int length = 10]) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return List.generate(length, (index) => chars[rnd.nextInt(chars.length)])
        .join();
  }

  // Function to open a Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = _selectedDate ?? DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text =
            "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      });
    }
  }

  // Firebase function to insert data into Firestore
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Process the form
      final creditName = _creditNameController.text;
      final creditAmount = _creditAmountController.text;
      final phoneNumber = _phoneNumberController.text;
      final userId = _userIdController.text;
      final address = _addressController.text;
      final creditDate = _dateController.text;

      // Prepare the data to be stored
      Map<String, dynamic> userData = {
        'creditName': creditName,
        'creditAmount': creditAmount,
        'phoneNumber': phoneNumber,
        'userId': userId,
        'address': address,
        'creditDate': creditDate,
      };

      try {
        String uid =
            FirebaseAuth.instance.currentUser!.uid; // Get current user ID
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(uid);

        // Add data to the 'creditUserList' subcollection for the user
        await userRef.collection('creditUserList').add(userData);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form submitted and data saved!')));

        // Refresh the screen by replacing the current screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CreditFormScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void clear() {
    _creditNameController.clear();
    _creditAmountController.clear();
    _phoneNumberController.clear();
    _userIdController.clear();
    _addressController.clear();
    _dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Form'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Credit Name
              _buildTextField(
                controller: _creditNameController,
                label: 'Credit Name',
                icon: Icons.person,
                keyboardType: TextInputType.text,
              ),

              SizedBox(height: 16),

              // Credit Amount
              _buildTextField(
                controller: _creditAmountController,
                label: 'Credit Amount',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 16),

              // Phone Number
              _buildTextField(
                controller: _phoneNumberController,
                label: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phone Number';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // User ID
              _buildTextField(
                controller: _userIdController,
                label: 'User ID',
                icon: Icons.credit_card,
                readOnly: true,
              ),

              SizedBox(height: 16),

              // Address
              _buildTextField(
                controller: _addressController,
                label: 'Address',
                icon: Icons.home,
                keyboardType: TextInputType.text,
              ),

              SizedBox(height: 16),

              // Credit Date
              _buildTextField(
                controller: _dateController,
                label: 'Credit Date',
                icon: Icons.calendar_today,
                readOnly: true,
                onTap: () => _selectDate(context),
              ),

              SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: Text('Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom TextField widget for form fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    void Function()? onTap,
    String? Function(String?)? validator,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal, width: 2),
          ),
        ),
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
      ),
    );
  }
}
