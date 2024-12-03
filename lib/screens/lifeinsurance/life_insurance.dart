import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class LifeInsuranceScreen extends StatefulWidget {
  @override
  _LifeInsuranceScreenState createState() => _LifeInsuranceScreenState();
}

class _LifeInsuranceScreenState extends State<LifeInsuranceScreen> {
  Uint8List? policyDocumentBytes;
  String? policyDocumentFileName;
  bool isUploading = false;
  double uploadProgress = 0;
  bool isDocumentUploaded = false;

  // Form field controllers
  final TextEditingController _policyNumberController = TextEditingController();
  final TextEditingController _insuredNameController = TextEditingController();
  final TextEditingController _coverageAmountController =
      TextEditingController();
  final TextEditingController _beneficiaryNameController =
      TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  Future<void> _pickDocument() async {
    try {
      final imageInfo = await ImagePickerWeb.getImageInfo();

      if (imageInfo != null && imageInfo.data != null) {
        setState(() {
          policyDocumentBytes = imageInfo.data;
          policyDocumentFileName = imageInfo.fileName;
          isDocumentUploaded = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No document selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking document: $e')),
      );
    }
  }

  Future<String?> _uploadDocument(
      Uint8List documentBytes, String documentName) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'insurance_documents/$documentName-${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask = storageRef.putData(documentBytes);

      uploadTask.snapshotEvents.listen((event) {
        double progress =
            (event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                100;
        setState(() {
          uploadProgress = progress;
        });
        print("Upload is $progress% done.");
      });

      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload document: $e')),
      );
      return null;
    }
  }

  Future<void> _submitForm() async {
    if (_validateInputs()) {
      setState(() {
        isUploading = true;
        uploadProgress = 0;
      });

      try {
        String? documentUrl =
            await _uploadDocument(policyDocumentBytes!, 'policy_document');

        await FirebaseFirestore.instance.collection('life_insurance').add({
          'policyNumber': _policyNumberController.text,
          'insuredName': _insuredNameController.text,
          'coverageAmount': _coverageAmountController.text,
          'beneficiaryName': _beneficiaryNameController.text,
          'remarks': _remarksController.text,
          'documentUrl': documentUrl,
        });

        setState(() {
          isUploading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form submitted successfully!')),
        );

        _clearForm();
      } catch (e) {
        setState(() {
          isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit form: $e')),
        );
      }
    }
  }

  bool _validateInputs() {
    if (_policyNumberController.text.isEmpty ||
        _insuredNameController.text.isEmpty ||
        _coverageAmountController.text.isEmpty ||
        _beneficiaryNameController.text.isEmpty ||
        policyDocumentBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Please fill all required fields and upload a document')),
      );
      return false;
    }
    return true;
  }

  void _clearForm() {
    _policyNumberController.clear();
    _insuredNameController.clear();
    _coverageAmountController.clear();
    _beneficiaryNameController.clear();
    _remarksController.clear();
    setState(() {
      policyDocumentBytes = null;
      isDocumentUploaded = false;
      uploadProgress = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Life Insurance Form')),
      body: isUploading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _policyNumberController,
                      decoration: InputDecoration(
                        labelText: 'Policy Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _insuredNameController,
                      decoration: InputDecoration(
                        labelText: 'Insured Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _coverageAmountController,
                      decoration: InputDecoration(
                        labelText: 'Coverage Amount (\$)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _beneficiaryNameController,
                      decoration: InputDecoration(
                        labelText: 'Beneficiary Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _remarksController,
                      decoration: InputDecoration(
                        labelText: 'Remarks',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 20),
                    Text('Upload Policy Document'),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _pickDocument,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDocumentUploaded ? Colors.green : null,
                      ),
                      child: isDocumentUploaded
                          ? Text('Document Uploaded')
                          : Text('Upload Document'),
                    ),
                    if (uploadProgress > 0) ...[
                      SizedBox(height: 20),
                      LinearProgressIndicator(value: uploadProgress / 100),
                      Text(
                          'Upload Progress: ${uploadProgress.toStringAsFixed(2)}%'),
                    ],
                    SizedBox(height: 30),
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
