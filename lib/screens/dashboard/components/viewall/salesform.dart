import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class SalesForm extends StatefulWidget {
  @override
  _SalesFormState createState() => _SalesFormState();
}

class _SalesFormState extends State<SalesForm> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();

  // Variables for images and date
  io.File? _productImage; // Mobile
  Uint8List? _webImage; // Web
  final picker = ImagePicker();
  DateTime? _selectedExpireDate;

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        if (kIsWeb) {
          pickedFile.readAsBytes().then((bytes) {
            setState(() {
              _webImage = bytes;
            });
          });
        } else {
          // For Mobile
          _productImage = io.File(pickedFile.path);
        }
      }
    });
  }

  Future<String?> _uploadProfileImage(io.File file) async {
    try {
      // Get the filename
      String fileName = path.basename(file.path);
      print('fileName$fileName');
      // Create a reference to the storage location
      Reference reference =
          FirebaseStorage.instance.ref().child('imageUrl/$fileName');

      // Upload the file
      UploadTask uploadTask = reference.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Image uploaded to: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  // Method to show date picker and select expiration date
  Future<void> _selectExpireDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedExpireDate) {
      setState(() {
        _selectedExpireDate = picked;
        expireDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Method to submit the form and insert data into Firestore
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Get the current user ID
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not logged in')),
          );
          return;
        }

        String userId = currentUser.uid;

        // Upload image if selected
        String? imageUrl;
        if (_productImage != null) {
          imageUrl = await _uploadProfileImage(_productImage!);
          if (imageUrl == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image upload failed')),
            );
            return;
          }
        }

        // Create a sales data map
        Map<String, dynamic> salesData = {
          'productName': productNameController.text,
          'price': double.tryParse(priceController.text) ?? 0.0,
          'discount': double.tryParse(discountController.text) ?? 0.0,
          'description': descriptionController.text,
          'weight': double.tryParse(weightController.text) ?? 0.0,
          'expireDate': _selectedExpireDate != null
              ? DateFormat('yyyy-MM-dd').format(_selectedExpireDate!)
              : null,
          'imageUrl': imageUrl.toString() ?? 'No Image',
          'timestamp': FieldValue.serverTimestamp(),
        };
        print('image$imageUrl');

        // Insert the data into Firestore
        await FirebaseFirestore.instance
            .collection('sales')
            .doc(userId)
            .set(salesData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product Submitted Successfully')),
        );

        // Reset the form
        _formKey.currentState?.reset();
        setState(() {
          productNameController.clear();
          priceController.clear();
          discountController.clear();
          descriptionController.clear();
          weightController.clear();
          expireDateController.clear();
          _productImage = null;
          _webImage = null;
          _selectedExpireDate = null;
        });
      } catch (e) {
        print("Error submitting form: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting product')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Product Name
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),

              // Price
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price (in \$)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),

              // Discount
              TextFormField(
                controller: discountController,
                decoration: InputDecoration(
                  labelText: 'Discount (in %)',
                ),
                keyboardType: TextInputType.number,
              ),

              // Description
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
              ),

              // Weight (grams or ml)
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(
                  labelText: 'Weight (grams/ml)',
                ),
                keyboardType: TextInputType.number,
              ),

              // Expiration Date
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Expiration Date',
                ),
                onTap: () {
                  _selectExpireDate(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an expiration date';
                  }
                  return null;
                },
                controller: expireDateController,
                readOnly: true,
              ),

              // Product Image
              SizedBox(height: 10),
              Row(
                children: [
                  if (kIsWeb)
                    _webImage == null
                        ? Text('No image selected')
                        : Image.memory(
                            _webImage!,
                            width: 100,
                            height: 100,
                          )
                  else
                    _productImage == null
                        ? Text('No image selected')
                        : Image.file(
                            _productImage!,
                            width: 100,
                            height: 100,
                          ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pick Image'),
                  ),
                ],
              ),

              // Submit Button
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
