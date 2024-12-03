import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker_web/image_picker_web.dart';

class TravellingInsurance extends StatefulWidget {
  @override
  _TravellingInsuranceState createState() => _TravellingInsuranceState();
}

class _TravellingInsuranceState extends State<TravellingInsurance> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? cnicFrontImageBytes;
  Uint8List? cnicBackImageBytes;
  String? cnicFrontFileName;
  String? cnicBackFileName;
  bool isFrontUploaded = false;
  bool isBackUploaded = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController street2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController numberPlateController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  File? _documentImage;

  String selectedCountry = 'Please Select';
  List<String> countries = ['Please Select', 'USA', 'Canada', 'UK', 'India'];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Add data to Firestore
        await FirebaseFirestore.instance.collection('travelInsurance').add({
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'street': streetController.text,
          'street2': street2Controller.text,
          'city': cityController.text,
          'state': stateController.text,
          'postalCode': postalController.text,
          'country': selectedCountry,
          'vehicleName': vehicleNameController.text,
          'numberPlate': numberPlateController.text,
          'vehicleModel': vehicleModelController.text,
          'documentImage': _documentImage != null
              ? _documentImage!.path
              : null, // Save image path for now
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
    }
  }

  void _clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    streetController.clear();
    street2Controller.clear();
    cityController.clear();
    stateController.clear();
    postalController.clear();
    vehicleNameController.clear();
    numberPlateController.clear();
    vehicleModelController.clear();
    setState(() {
      selectedCountry = 'Please Select';
      _documentImage = null;
    });
  }

  Future<void> _pickImage(bool isFront) async {
    try {
      final imageInfo = await ImagePickerWeb.getImageInfo();
      print("Image info: $imageInfo");
      if (imageInfo != null && imageInfo.data != null) {
        setState(() {
          if (isFront) {
            cnicFrontImageBytes = imageInfo.data;
            cnicFrontFileName = imageInfo.fileName;
            isFrontUploaded = true;
          } else {
            cnicBackImageBytes = imageInfo.data;
            cnicBackFileName = imageInfo.fileName;
            isBackUploaded = true;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('No image selected or issue in picking image')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  // Method to remove the front image
  void _removeFrontImage() {
    setState(() {
      cnicFrontImageBytes = null;
      isFrontUploaded = false;
    });
  }

  // Method to remove the back image
  void _removeBackImage() {
    setState(() {
      cnicBackImageBytes = null;
      isBackUploaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Travel Insurance Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(labelText: 'Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: streetController,
                decoration: InputDecoration(labelText: 'Street'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your street address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: street2Controller,
                decoration: InputDecoration(labelText: 'Street 2'),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(labelText: 'City'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: stateController,
                      decoration: InputDecoration(labelText: 'State'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your state';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: postalController,
                decoration: InputDecoration(labelText: 'Postal Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your postal code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCountry,
                items: countries.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCountry = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == 'Please Select') {
                    return 'Please select your country';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: vehicleNameController,
                decoration: InputDecoration(labelText: 'Vehicle Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vehicle name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: numberPlateController,
                decoration: InputDecoration(labelText: 'Number Plate'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vehicle number plate';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: vehicleModelController,
                decoration: InputDecoration(labelText: 'Vehicle Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vehicle model';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _pickImage(true),
                child: Text('Upload Front of Document'),
              ),
              SizedBox(height: 10),
              if (isFrontUploaded && cnicFrontImageBytes != null)
                Stack(
                  children: [
                    Image.memory(cnicFrontImageBytes!, height: 150),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: _removeFrontImage,
                      ),
                    ),
                  ],
                )
              else
                Text('No front image uploaded'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickImage(false),
                child: Text('Upload Back of Document'),
              ),
              SizedBox(height: 10),
              if (isBackUploaded && cnicBackImageBytes != null)
                Stack(
                  children: [
                    Image.memory(cnicBackImageBytes!, height: 150),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: _removeBackImage,
                      ),
                    ),
                  ],
                )
              else
                Text('No back image uploaded'),
              SizedBox(height: 20),
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
}
