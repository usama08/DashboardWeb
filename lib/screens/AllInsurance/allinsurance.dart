import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:dashboarweb/screens/Auth/controller/authcontroller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:fancy_button_new/fancy_button_new.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../Widgets/global_textfield.dart';

class VehicleFormScreen extends StatefulWidget {
  @override
  _VehicleFormScreenState createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends State<VehicleFormScreen> {
  // Define your variables
  String? selectedBrand;
  String? selectedModel;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  int? selectedYear;
  Uint8List? cnicFrontImageBytes;
  Uint8List? cnicBackImageBytes;
  String? cnicFrontFileName;
  String? cnicBackFileName;
  bool isUploading = false;
  double uploadProgress = 0;
  bool isFrontUploaded = false;
  bool isBackUploaded = false;
  int selectedBrandId = 0;
  int? insuranceID;
  String SelectedInsurance = '';
  List<Map<String, dynamic>> brandList = [];
  List<Map<String, dynamic>> insuranceList = [];
  List<String> modellist = [];
  String secureKey = "";

  List<int> yearList = List.generate(45, (index) => 1980 + index);
  var authcontroller = Get.put(AuthController());
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _registerNoController = TextEditingController();
  final TextEditingController _chasiNoController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _engineNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController trvaelFrom = TextEditingController();
  final TextEditingController trvaelTO = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController passportController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print("Initializing VehicleFormScreen");
    getData();
    getInsuranceTable();
    secureKey = _generateSecureKey();
    print('policyID: ${secureKey.toString()}');
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

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    print("Selecting date: $isStartDate");
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
    try {
      final imageInfo = await ImagePickerWeb.getImageInfo();

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

        // No need to send the image to the server here
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> sendImagesToServer() async {
    print('Selected Brand: $selectedBrand');
    print('Selected Model: $selectedModel');
    print('Register No: ${_registerNoController.text}');
    print('Chasi No: ${_chasiNoController.text}');
    print('CNIC: ${_cnicController.text}');
    print('Engine No: ${_engineNoController.text}');
    print('Address: ${_addressController.text}');
    print('Year of Manufacture: $selectedYear');
    print('Remarks: ${_remarksController.text}');
    print('Start Date: ${selectedStartDate?.toIso8601String()}');
    print('End Date: ${selectedEndDate?.toIso8601String()}');
    print('User ID: ${authcontroller.userData.value['UserID'].toString()}');
    print('policyID: ${secureKey.toString()}');

    if (!validateInputs()) {
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:3000/registerVehicle'), // Your API endpoint
      );

      final frontFileName =
          '${DateTime.now().millisecondsSinceEpoch}_cnicFront${path.extension(cnicFrontFileName!)}';
      final backFileName =
          '${DateTime.now().millisecondsSinceEpoch}_cnicBack${path.extension(cnicBackFileName!)}';

      // Add image data
      request.files.add(
        http.MultipartFile.fromBytes(
          'cnicFrontImage',
          cnicFrontImageBytes!,
          filename: frontFileName,
        ),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'cnicBackImage',
          cnicBackImageBytes!,
          filename: backFileName,
        ),
      );

      // Add other fields
      request.fields['brand'] = selectedBrand.toString() ?? '';
      request.fields['model'] = selectedModel.toString() ?? '';
      request.fields['registerNo'] = _registerNoController.text;
      request.fields['chasiNo'] = _chasiNoController.text;
      request.fields['cnic'] = _cnicController.text;
      request.fields['engineNo'] = _engineNoController.text;
      request.fields['address'] = _addressController.text;
      request.fields['yearManufacture'] = selectedYear?.toString() ?? '';
      request.fields['remarks'] = _remarksController.text;
      request.fields['startDate'] = selectedStartDate?.toIso8601String() ?? '';
      request.fields['endDate'] = selectedEndDate?.toIso8601String() ?? '';
      request.fields['userID'] =
          authcontroller.userData.value['UserID'].toString();
      request.fields['insuranceID'] = insuranceID.toString();
      request.fields['insuranceName'] = SelectedInsurance.toString();
      request.fields['policyID'] = secureKey.toString();

      request.fields['userStatus'] = 'register';

      // Send the request
      var response = await request.send();

      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        print('Images uploaded successfully: ${responseData.body}');
        clear(); // Refresh the page after successful upload
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VehicleFormScreen()),
        );
      } else {
        print(
            'Failed to upload images: ${response.statusCode} - ${response.reasonPhrase}');
        print('Server Response: ${responseData.body}');
      }
    } catch (e) {
      print('Error sending images to server: $e');
    }
  }

  bool validateInputs() {
    if (selectedBrand == null ||
        selectedModel == null ||
        _registerNoController.text.isEmpty ||
        _chasiNoController.text.isEmpty ||
        _cnicController.text.isEmpty ||
        _engineNoController.text.isEmpty ||
        _addressController.text.isEmpty ||
        cnicFrontImageBytes == null ||
        selectedYear == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return false;
    }
    return true;
  }

  bool validateTravel() {
    if (passportController.text.isEmpty ||
        trvaelFrom.text.isEmpty ||
        _cnicController.text.isEmpty ||
        trvaelTO.text.isEmpty ||
        _addressController.text.isEmpty ||
        cnicFrontImageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return false;
    }
    return true;
  }

  void _removeImage(bool isFront) {
    setState(() {
      if (isFront) {
        cnicFrontImageBytes = null;
        isFrontUploaded = false;
      } else {
        cnicBackImageBytes = null;
        isBackUploaded = false;
      }
    });
  }

  void clear() {
    _registerNoController.clear();
    _chasiNoController.clear();
    _cnicController.clear();
    _engineNoController.clear();
    _addressController.clear();
    _remarksController.clear();
    selectedBrand = null;
    selectedModel = null;
    cnicFrontImageBytes = null;
    cnicBackImageBytes = null;
    selectedYear = null;
    selectedStartDate = null;
    selectedEndDate = null;
    passportController.clear();
    isFrontUploaded = false;
    isBackUploaded = false;
  }

  Future<void> getData() async {
    print("Fetching brand data");
    var url = Uri.parse('http://127.0.0.1:3000/getbrand');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        brandList = data.map<Map<String, dynamic>>((item) {
          return {'id': item['id'], 'brand': item['brand']};
        }).toList();
      });
      print('Data fetched: ${response.body}');
    } else {
      print('Failed to fetch data');
    }
  }

  Future<void> postID() async {
    print("Posting ID: $selectedBrandId");
    var url = Uri.parse('http://127.0.0.1:3000/modelfetch');

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': selectedBrandId}),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        modellist.clear();
        modellist = data.map<String>((model) => model['model']).toList();
      });
      print('Data fetched: ${modellist}');
    } else {
      print('Failed to fetch data');
    }
  }

  /// -------------   All Insurance Table -----------------///
  Future<void> getInsuranceTable() async {
    print("Fetching brand data");
    var url = Uri.parse('http://127.0.0.1:3000/getinsurance');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        insuranceList = data.map<Map<String, dynamic>>((item) {
          return {'id': item['id'], 'insurance': item['insurance']};
        }).toList();
      });
      print('Data fetched: ${response.body}');
    } else {
      print('Failed to fetch data');
    }
  }

  /// -----------------  Travelling Insurance Table ---------------  ///

  Future<void> createTravelInsurance() async {
    print('Selected Brand: ${trvaelFrom.text}');
    print('Selected Model: ${trvaelTO.text}');
    print('Register No: ${passportController.text}');
    print('CNIC: ${_cnicController.text}');
    print('Address: ${_addressController.text}');
    print('Remarks: ${_remarksController.text}');
    print('Start Date: ${selectedStartDate?.toIso8601String()}');
    print('End Date: ${selectedEndDate?.toIso8601String()}');
    print('User ID: ${authcontroller.userData.value['UserID'].toString()}');

    if (!validateTravel()) {
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://127.0.0.1:3000/travellingInsurance'), // Your API endpoint
      );

      final frontFileName =
          '${DateTime.now().millisecondsSinceEpoch}_cnicFront${path.extension(cnicFrontFileName!)}';
      final backFileName =
          '${DateTime.now().millisecondsSinceEpoch}_cnicBack${path.extension(cnicBackFileName!)}';

      // Add image data
      request.files.add(
        http.MultipartFile.fromBytes(
          'cnicFrontImage',
          cnicFrontImageBytes!,
          filename: frontFileName,
        ),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'cnicBackImage',
          cnicBackImageBytes!,
          filename: backFileName,
        ),
      );

      // Add other fields
      request.fields['from'] = trvaelFrom.text;
      request.fields['to'] = trvaelTO.text;
      request.fields['cnic'] = _cnicController.text;
      request.fields['address'] = _addressController.text;
      request.fields['passportNo'] = passportController.text;
      request.fields['remarks'] = _remarksController.text;
      request.fields['startDate'] = selectedStartDate?.toIso8601String() ?? '';
      request.fields['endDate'] = selectedEndDate?.toIso8601String() ?? '';
      request.fields['userID'] =
          authcontroller.userData.value['UserID'].toString();
      request.fields['insuranceID'] = insuranceID.toString();
      request.fields['insuranceName'] = SelectedInsurance.toString();
      request.fields['policyID'] = secureKey.toString();
      request.fields['userStatus'] = 'register';

      // Send the request
      var response = await request.send();

      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        print('Images uploaded successfully: ${responseData.body}');
        clear();
      } else {
        print(
            'Failed to upload images: ${response.statusCode} - ${response.reasonPhrase}');
        print('Server Response: ${responseData.body}');
      }
    } catch (e) {
      print('Error sending images to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select your Insurance')),
      body: isUploading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                // ignore: unused_local_variable
                bool isWideScreen = constraints.maxWidth > 600;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Select your Insurance',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          isExpanded: true,
                          value: insuranceID,
                          hint: Text("Select a Insurance Type"),
                          items: insuranceList
                              .map<DropdownMenuItem<int>>((InsuranceItem) {
                            return DropdownMenuItem<int>(
                              value: InsuranceItem['id'],
                              child: Text(InsuranceItem['insurance']),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              insuranceID = newValue;
                              print('insuranceID$insuranceID');
                              SelectedInsurance = insuranceList.firstWhere(
                                  (item) =>
                                      item['id'] == newValue)['insurance'];
                              clear();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (insuranceID != null &&
                        SelectedInsurance == 'travelling insurance') ...[
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: trvaelFrom,
                              label: 'Travelling From',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: trvaelTO,
                              label: 'Travelling To',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
                                child: CustomTextField(
                                  controller: TextEditingController(
                                    text: selectedEndDate != null
                                        ? "${selectedEndDate!.day}/${selectedEndDate!.month}/${selectedEndDate!.year}"
                                        : '',
                                  ),
                                  label: 'End Date',
                                  isReadOnly: true,
                                  onTap: () => _selectDate(context,
                                      false), // Calls the date picker on tap
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _cnicController,
                              label: 'CNIC',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: phone,
                              label: 'Phone No',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _addressController,
                              label: 'Address',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: passportController,
                              label: 'Passport No',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _remarksController,
                              label: 'Remarks',
                            ),
                          ),
                        ],
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
                                    top: 5,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(true),
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 22,
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
                                    top: 5,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(false),
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      MyFancyButton(
                        width: 240,
                        borderRadius: 10,
                        isIconButton: false,
                        fontSize: 15,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                        shadowColor: Colors.greenAccent.withOpacity(0.25),
                        text: isUploading ? "Uploading..." : "Submit",
                        tap: () {
                          createTravelInsurance();
                        },
                        fontColor: Colors.white,
                        buttonColor: Colors.green,
                        hasShadow: true,
                      ),
                    ],
                    if (insuranceID != null &&
                        SelectedInsurance == 'motor insurance') ...[
                      Row(
                        children: [
                          Expanded(
                            child:
                                DropdownButtonFormField<Map<String, dynamic>>(
                              menuMaxHeight: 360,
                              hint: Text('Select Brand'),
                              value: selectedBrand == null
                                  ? null
                                  : brandList.firstWhere(
                                      (brand) =>
                                          brand['brand'] == selectedBrand,
                                      orElse: () => <String, dynamic>{},
                                    ),
                              items: brandList
                                  .map((Map<String, dynamic> brandData) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: brandData,
                                  child: Text(brandData['brand']),
                                );
                              }).toList(),
                              onChanged: (Map<String, dynamic>? newValue) {
                                setState(() {
                                  selectedBrand = newValue?['brand'];
                                  selectedBrandId = newValue?['id'];
                                  postID();
                                  selectedModel = null;
                                  print('Selected Brand ID: $selectedBrandId');
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
                              menuMaxHeight: 360,
                              hint: Text('Select Model'),
                              value: selectedModel,
                              items: modellist.map((String model) {
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
                                child: CustomTextField(
                                  controller: TextEditingController(
                                    text: selectedEndDate != null
                                        ? "${selectedEndDate!.day}/${selectedEndDate!.month}/${selectedEndDate!.year}"
                                        : '',
                                  ),
                                  label: 'End Date',
                                  isReadOnly: true,
                                  onTap: () => _selectDate(context,
                                      false), // Calls the date picker on tap
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _registerNoController,
                              label: 'Register No',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: _chasiNoController,
                              label: 'Chassi No',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _cnicController,
                              label: 'CNIC',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: _engineNoController,
                              label: 'Engine No',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
                            child: CustomTextField(
                              controller: _addressController,
                              label: 'Address',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _remarksController,
                        label: 'Remarks',
                        maxLines: 3,
                      ),
                      SizedBox(height: 20),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Upload CNIC Front and Back Side ')),
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
                                    top: 5,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(true),
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 22,
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
                                    top: 5,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(false),
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isUploading)
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: [
                              LinearProgressIndicator(
                                backgroundColor: Colors.grey[200],
                                value: uploadProgress / 100,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                              ),
                              Text(
                                  'Upload Progress: ${uploadProgress.toStringAsFixed(2)}%'),
                            ],
                          ),
                        ),
                      SizedBox(height: 20),
                      MyFancyButton(
                        width: 240,
                        borderRadius: 10,
                        isIconButton: false,
                        fontSize: 15,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                        shadowColor: Colors.greenAccent.withOpacity(0.25),
                        text: isUploading ? "Uploading..." : "Submit",
                        tap: () {
                          sendImagesToServer();
                        },
                        fontColor: Colors.white,
                        buttonColor: Colors.green,
                        hasShadow: true,
                      ),
                    ],
                  ]),
                );
              },
            ),
    );
  }
}
