import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/Api/allApies.dart';
import 'package:http/http.dart' as http;
import '../../AdminSide/screen/adminscreen.dart';
import '../../main/main_screen.dart';

class AuthController extends GetxController {
  final TextEditingController portalUsername = TextEditingController();
  final TextEditingController portalPassword = TextEditingController();
  final TextEditingController coPhone = TextEditingController();
  final TextEditingController coName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController adminname = TextEditingController();
  final TextEditingController adminpassword = TextEditingController();
  RxList<Map<String, dynamic>> company = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> userList = [];
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxBool obscureText = true.obs;
  // ignore: unnecessary_null_comparison, invalid_use_of_protected_member
  bool get isLoggedIn => userData.value != null;
  // Reactive variable to store user data
  var userData = {}.obs;
  int? selectedCompanyId;
  String selectedCompany = '';
  // get company Api's integration

  bool validateInputs(context) {
    if (portalUsername == null ||
        portalPassword == null ||
        selectedCompanyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return false;
    }
    return true;
  }

  void updatePhone(String newPhone) {
    userData.value!['Phone'] = newPhone;
    userData.refresh();
  }

  void updateEmail(String newEmail) {
    userData.value!['Email'] = newEmail;
    userData.refresh();
  }

  void updatePassword(String newPassword) {
    // Update password logic (likely calling an API or Firebase)
    print('Password updated');
  }

  Future<void> getCompany() async {
    var url = Uri.parse(ApiURls.companyget);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      company.value = data.map<Map<String, dynamic>>((item) {
        return {'id': item['id'], 'company': item['company']};
      }).toList();

      print('Data fetched: ${response.body}');
    } else {
      print('Failed to fetch data');
    }
  }

  // Login Function
  Future<void> loginIndividual() async {
    String apiUrl =
        '${ApiURls.loginInd}?phone=${coPhone.text}&password=${portalPassword.text}&companyID=$selectedCompanyId';

    try {
      isLoading(true);

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          // Login successful, store user data
          userData.value = responseData['Data'];
          userData.value['portalUsername'];
          print('afterid${userData.value['id']}');
          // Navigate to MainScreen on successful login
          Get.to(() => MainScreen());
          coPhone.clear();
          portalPassword.clear();
          selectedCompanyId = 0;
          print('Login Successful: ${responseData['message']}');
        } else {
          // Login failed, show error message
          errorMessage.value = responseData['message'];
          _showErrorDialog(responseData['message']);
        }
      } else {
        // Handle server errors
        errorMessage.value =
            'Server responded with status code ${response.statusCode}';
        _showErrorDialog('Server error. Please try again later.');
      }
    } catch (e) {
      // Handle any other errors (e.g., network issues)
      errorMessage.value = 'Error occurred: $e';
      _showErrorDialog('An error occurred. Please check your connection.');
    } finally {
      isLoading(false);
    }
  }

  // Show error dialog using GetX's built-in dialog function
  void _showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // Close the dialog
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> loginCooperative(BuildContext context) async {
    String apiUrl =
        '${ApiURls.loginCop}?portalUsername=${portalUsername.text}&password=${portalPassword.text}&companyID=$selectedCompanyId';

    try {
      isLoading(true); // Show loading state

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          // Login successful, store user data
          userData.value = responseData['Data'];
          print('afterid${userData.value['UserID']}');
          // Print the entire userData map
          print('User Data: ${userData.value}');

          // Navigate to MainScreen on successful login
          Get.to(() => MainScreen());

          // Clear input fields
          portalUsername.clear();
          portalPassword.clear();
          selectedCompanyId = 0;

          print('Login Successful: ${responseData['message']}');
        } else {
          // Login failed, show error message
          errorMessage.value = responseData['message'];
          _showErrorDialog(responseData['message']);
        }
      } else {
        // Handle server errors
        errorMessage.value =
            'Server responded with status code ${response.statusCode}';
        _showErrorDialog('Server error. Please try again later.');
      }
    } catch (e) {
      // Handle any other errors (e.g., network issues)
      errorMessage.value = 'Error occurred: $e';
      _showErrorDialog('An error occurred. Please check your connection.');
    } finally {
      isLoading(false); // Stop loading state
    }
  }

  // ------------    Profile Update -------------------  //
  Future<void> profileUpdate({
    required String userID,
    int? phone,
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    // API URL for updating profile
    const String apiUrl = 'http://127.0.0.1:3000/updateUser';

    try {
      // Prepare the request body
      Map<String, dynamic> body = {
        'id': userID,
      };

      // Add the optional parameters if they are provided
      if (phone != null) {
        body['phone'] = phone;
      }
      if (email != null) {
        body['email'] = email;
      }
      if (password != null) {
        body['password'] = password;
      }

      // Send the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Handle the response
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          // Show success message
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')),
          );
        } else {
          // Show error message if the server returned success: false
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(content: Text('Error: ${responseData['message']}')),
          );
        }
      } else {
        // Show error message if the status code is not 200
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

// ---------------------  Admin Register -------------------------- //
  Future<void> adminRegister() async {
    final String url = '${ApiURls.adminreg}';

    // Prepare data to be sent
    Map<String, String> requestBody = {
      'fullName': name.text,
      'email': email.text,
      'password': password.text,
      'type': 'admin'
    };

    try {
      // Send a POST request to the server
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Check for a successful response
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print('Success: ${responseData['message']}');
        // Show success message
        Get.snackbar("Success", responseData['message']);
      } else if (response.statusCode == 409) {
        // Handle duplicate user error
        var responseData = jsonDecode(response.body);
        print('Error: ${responseData['error']}');
        Get.snackbar("Error", responseData['error']);
      } else {
        print('Failed to register admin. Status code: ${response.statusCode}');
        Get.snackbar("Error", "Failed to register admin");
      }
    } catch (error) {
      print('Error during API request: $error');
      Get.snackbar("Error", "Internal Server Error");
    }
  }

  /// ----------------------------    Login Admin ---------------------- ///

  Future<void> adminLogin(BuildContext context) async {
    // Check if input fields are not empty
    if (adminname.text.isEmpty || adminpassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both username and password")),
      );
      return;
    }

    try {
      // Make GET request to the API
      final response = await http.get(
        Uri.parse(
            '${ApiURls.adminlogin}?name=${adminname.text}&password=${adminpassword.text}'),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = jsonDecode(response.body);

        if (data['success']) {
          // Login successful, you can access user data from the 'Data' field
          final userData = data['Data'];
          print("Login successful: ${userData['FullName']}");
          Get.to(() => AdminScreen());

          // Show success message or navigate to a different screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Successful: ${userData['name']}")),
          );

          // Example of navigating to the home screen or another screen
          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
        } else {
          // Show error message from the server
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        // Show error message for a non-200 status code
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed. Please try again later.")),
        );
      }
    } catch (error) {
      print("Login error: $error");
      // Show error message for exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }
}
