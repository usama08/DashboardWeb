import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';

class HealthInsuranceForm extends StatefulWidget {
  @override
  _HealthInsuranceFormState createState() => _HealthInsuranceFormState();
}

class _HealthInsuranceFormState extends State<HealthInsuranceForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emergencyPhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  Uint8List? documentBytes;
  String? documentFileName;
  bool isUploading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isUploading = true;
      });

      try {
        await FirebaseFirestore.instance.collection('healthInsurance').add({
          'name': nameController.text,
          'fatherName': fatherNameController.text,
          'city': cityController.text,
          'startDate': startDateController.text,
          'endDate': endDateController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'emergencyPhone': emergencyPhoneController.text,
          'address': addressController.text,
          'remarks': remarksController.text,
          'documentFileName': documentFileName,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form submitted successfully!')),
        );
        _clearForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit form: $e')),
        );
      }

      setState(() {
        isUploading = false;
      });
    }
  }

  void _clearForm() {
    nameController.clear();
    fatherNameController.clear();
    cityController.clear();
    startDateController.clear();
    endDateController.clear();
    emailController.clear();
    phoneController.clear();
    emergencyPhoneController.clear();
    addressController.clear();
    remarksController.clear();
    setState(() {
      documentBytes = null;
      documentFileName = null;
    });
  }

  Future<void> _pickDocument() async {
    try {
      final imageInfo = await ImagePickerWeb.getImageInfo();
      if (imageInfo != null && imageInfo.data != null) {
        setState(() {
          documentBytes = imageInfo.data;
          documentFileName = imageInfo.fileName;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Document selected successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No document selected!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting document: $e')),
      );
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Insurance Form')),
      body: isUploading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                              controller: nameController, label: 'Name'),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                              controller: fatherNameController,
                              label: 'Father Name'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildTextField(controller: cityController, label: 'City'),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDatePickerField(
                              controller: startDateController,
                              label: 'Start Date',
                              context: context),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildDatePickerField(
                              controller: endDateController,
                              label: 'End Date',
                              context: context),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                        controller: emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                              controller: phoneController,
                              label: 'Phone',
                              keyboardType: TextInputType.phone),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                              controller: emergencyPhoneController,
                              label: 'Emergency Phone',
                              keyboardType: TextInputType.phone),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                        controller: addressController, label: 'Address'),
                    SizedBox(height: 16),
                    _buildTextField(
                        controller: remarksController,
                        label: 'Remarks',
                        maxLines: 3),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _pickDocument,
                      child: Text(documentFileName != null
                          ? 'Document Selected: $documentFileName'
                          : 'Select Document'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String label,
    required BuildContext context,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () => _selectDate(context, controller),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }
}
