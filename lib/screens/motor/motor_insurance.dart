import 'package:fancy_button_new/fancy_button_new.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VehicleFormScreen extends StatefulWidget {
  @override
  _VehicleFormScreenState createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends State<VehicleFormScreen> {
  String? selectedBrand;
  String? selectedModel;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  int? selectedYear;
  File? cnicFrontImage;
  File? cnicBackImage;
  bool isUploading = false;
  bool isFrontUploaded = false;
  bool isBackUploaded = false;

  List<String> brandList = ['Honda', 'Suzuki'];
  List<String> hondaModels = ['Civic', 'Accord'];
  List<String> suzukiModels = ['Alto', 'Swift'];
  List<String> modelList = [];
  List<int> yearList = List.generate(45, (index) => 1980 + index);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _registerNoController = TextEditingController();
  final TextEditingController _chasiNoController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _engineNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = picked;
        } else {
          selectedEndDate = picked;
        }
      });
    }
  }

  Future<void> _pickImage(bool isFront) async {
    final picker = ImagePicker();
    setState(() {
      isUploading = true;
    });
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      isUploading = false;
      if (pickedFile != null) {
        if (isFront) {
          cnicFrontImage = File(pickedFile.path);
          isFrontUploaded = true;
        } else {
          cnicBackImage = File(pickedFile.path);
          isBackUploaded = true;
        }
      }
    });
  }

  void _removeImage(bool isFront) {
    setState(() {
      if (isFront) {
        cnicFrontImage = null;
        isFrontUploaded = false;
      } else {
        cnicBackImage = null;
        isBackUploaded = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle Registration Form')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // ignore: unused_local_variable
          bool isWideScreen = constraints.maxWidth > 600;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Brand and Model Dropdown
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        hint: Text('Select Brand'),
                        value: selectedBrand,
                        items: brandList.map((String brand) {
                          return DropdownMenuItem<String>(
                            value: brand,
                            child: Text(brand),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBrand = newValue;
                            modelList = newValue == 'Honda'
                                ? hondaModels
                                : suzukiModels;
                            selectedModel = null;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select Brand',
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        hint: Text('Select Model'),
                        value: selectedModel,
                        items: modelList.map((String model) {
                          return DropdownMenuItem<String>(
                            value: model,
                            child: Text(model),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedModel = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select Model',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Name and Last Name Fields
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Start Date and End Date Fields
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: TextEditingController(
                              text: selectedStartDate != null
                                  ? "${selectedStartDate!.day}/${selectedStartDate!.month}/${selectedStartDate!.year}"
                                  : '',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Start Date',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: TextEditingController(
                              text: selectedEndDate != null
                                  ? "${selectedEndDate!.day}/${selectedEndDate!.month}/${selectedEndDate!.year}"
                                  : '',
                            ),
                            decoration: InputDecoration(
                              labelText: 'End Date',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Register No and Chasi No Fields
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _registerNoController,
                        decoration: InputDecoration(
                          labelText: 'Register No',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _chasiNoController,
                        decoration: InputDecoration(
                          labelText: 'Chasi No',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // CNIC and Engine No Fields
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cnicController,
                        decoration: InputDecoration(
                          labelText: 'CNIC',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _engineNoController,
                        decoration: InputDecoration(
                          labelText: 'Engine No',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Year Manufacture and Address Fields
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        menuMaxHeight: 350,
                        hint: Text('Year'),
                        value: selectedYear,
                        items: yearList.map((int year) {
                          return DropdownMenuItem<int>(
                            value: year,
                            child: Text('$year'),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedYear = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Year Manufacture',
                        ),
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Remarks Field
                TextField(
                  controller: _remarksController,
                  decoration: InputDecoration(
                    labelText: 'Remarks',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          ElevatedButton(
                            onPressed: () => _pickImage(true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isFrontUploaded ? Colors.green : null,
                            ),
                            child: isFrontUploaded
                                ? Text('Uploaded Successfully')
                                : Text('Upload CNIC Front'),
                          ),
                          if (isFrontUploaded)
                            Positioned(
                              right: 10,
                              top: 5, // Adjust the top position
                              child: GestureDetector(
                                onTap: () => _removeImage(true),
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 22, // Adjust the size if needed
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Stack(
                        children: [
                          ElevatedButton(
                            onPressed: () => _pickImage(false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isBackUploaded ? Colors.green : null,
                            ),
                            child: isBackUploaded
                                ? Text('Uploaded Successfully')
                                : Text('Upload CNIC Back'),
                          ),
                          if (isBackUploaded)
                            Positioned(
                              right: 10,
                              top: 5, // Adjust the top position
                              child: GestureDetector(
                                onTap: () => _removeImage(false),
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 22, // Adjust the size if needed
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Show progress bar if isUploading is true
                if (isUploading)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),

                SizedBox(height: 20),

                // Custom Button at the end
                MyFancyButton(
                  width: 240,
                  borderRadius: 10,
                  isIconButton: false,
                  fontSize: 15,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                  shadowColor: Colors.greenAccent.withOpacity(0.25),
                  text: "Submit",
                  tap: () {},
                  fontColor: Colors.white,
                  buttonColor: Colors.green,
                  hasShadow: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
