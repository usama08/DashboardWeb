import 'dart:convert';
import 'package:dashboarweb/services/Api/allApies.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/motousermodel.dart';

class AdminController extends GetxController {
  RxList<dynamic> userNotifications = <dynamic>[].obs;

  RxList<MotorUser> motoruser = <MotorUser>[].obs; // Global observable list
  var muserid = 0.obs;
  RxBool isLoading = false.obs;
  var buttonLoadingStates = {}.obs; // Map to track button loading states

  // Method to update user status to approved
  Future<void> updateStatus(
      String userId, String policyId, String status) async {
    buttonLoadingStates[userId] = true;
    // Update status logic
    await Future.delayed(Duration(seconds: 1));
    // Update travellingStatusList with new status
    buttonLoadingStates[userId] = false;
  }

  // Method to delete user policy
  Future<void> deleteUserPolicy(String userId, String policyId) async {
    buttonLoadingStates[userId] = true;
    // Delete logic
    await Future.delayed(Duration(seconds: 1));
    // Remove the user from travellingStatusList
    buttonLoadingStates[userId] = false;
  }

  // Function to fetch data and save it into the motoruser list
  Future<void> allinsuranceuser() async {
    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse(ApiURls.motoruserget));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        // Print API response to debug
        print('API Response: ${data[0]['userID'].toString()}');
        motoruser.value = data.map((user) => MotorUser.fromJson(user)).toList();
        isLoading.value = false;
        if (motoruser.isNotEmpty) {
          muserid.value = motoruser[0].id;
        }
        print('Fetched User ID: ${muserid.value}');
        print('Fetched User ID: ${muserid.value}');
        isLoading.value = false;
        print('Fetched User username: ${motoruser[0].fullName}');
      } else {
        isLoading.value = false;
        print('Failed to fetch users with status code: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error occurred: $e');
    }
  }

  ///---------------------------------  Updat Motor ------------------------------//

  Future<void> updatemotor(int? userID, int? insuranceID, String insuranceName,
      String status) async {
    print('Request initiated to update motor status');
    print('Api hitt');
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(ApiURls.motorstatus),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user_ID': userID,
          'insurance_ID': insuranceID,
          'insuranceName': insuranceName,
          'status': status,
        }),
      );
      print('Request sent to server');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Success: ${responseData['message']}');
        isLoading.value = false;
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        isLoading.value = false;

        print('Error: ${errorData['error']}');
      } else if (response.statusCode == 409) {
        final errorData = jsonDecode(response.body);
        isLoading.value = false;

        print('Conflict: ${errorData['error']}');
      } else {
        isLoading.value = false;

        print('Error: Unexpected status code ${response.statusCode}');
      }
    } catch (error) {
      isLoading.value = false;

      print('Error: Failed to update motor status - $error');
    }
  }

  /// --------------------------   User Status Values ------------------------ ///

  var statusList = <dynamic>[].obs;

  // Function to fetch the status list from the server
  Future<void> getstatuslist() async {
    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse(ApiURls.getstatus));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];

        statusList.value = data;
        isLoading.value = false;

        print('Fetched Status List: $statusList');
      } else {
        print(
            'Failed to fetch status list with status code: ${response.statusCode}');
        isLoading.value = false;
      }
    } catch (e) {
      print('Error occurred: $e');
      isLoading.value = false;
    }
  }

  /// -----------------------  All Status  --------------------------- ///

  var userStatusList = <dynamic>[].obs;
  var travellingStatusList = <dynamic>[].obs;

  Future<void> alluserstatus() async {
    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse(ApiURls.userstatuslist));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        userStatusList.value = data;
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
        isLoading.value = false;
      }
    } catch (error) {
      print('Error fetching user status: $error');
      isLoading.value = false;
    }
  }

  /// ---------------------------  Travelling Insurance  ----------------------- ///

  Future<void> travelluserstatus() async {
    try {
      final response = await http.get(Uri.parse(ApiURls.travelledstatuslist));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        travellingStatusList.value = data;
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
        isLoading.value = false;
      }
    } catch (error) {
      print('Error fetching user status: $error');
    }
  }

  /// -----------------------------  update Status --------------------------------- ///

  Future<void> updateMotorStatus(
      int userID, String policyID, String newStatus) async {
    print('Request initiated to update motor status');
    print('Api hitt');
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(ApiURls.updateMotorStatus),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userID': userID,
          'policyID': policyID.toString(),
          'userStatus': newStatus.toString(),
        }),
      );
      print('Request sent to server');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Success: ${responseData['message']}');
        isLoading.value = false;
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        isLoading.value = false;

        print('Error: ${errorData['error']}');
      } else if (response.statusCode == 409) {
        final errorData = jsonDecode(response.body);
        print('Conflict: ${errorData['error']}');
        isLoading.value = false;
      } else {
        print('Error: Unexpected status code ${response.statusCode}');
        isLoading.value = false;
      }
    } catch (error) {
      print('Error: Failed to update motor status - $error');
      isLoading.value = false;
    }
  }

  /// -------------------------------  Delete the User ------------------------------ ///
  Future<void> deleteUserPolicies(int userID, String policyID) async {
    final url = Uri.parse(ApiURls.deletepolicy);
    isLoading.value = true;

    try {
      final body = json.encode({
        'userID': userID,
        'policyID': policyID.toString(),
      });

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('User policiy deleted successfully');
        isLoading.value = false;
      } else if (response.statusCode == 404) {
        print('Policy not found for the user');
        isLoading.value = false;
      } else {
        print('Failed to delete policies: ${response.statusCode}');
        print('Response: ${response.body}');
        isLoading.value = false;
      }
    } catch (e) {
      print('Error deleting policies: $e');
      isLoading.value = false;
    }
  }

  ///---------------------------------- Admin Chat Get use-----------------------------///
  Future<void> userNotification() async {
    try {
      // Define the API endpoint
      final url = Uri.parse(ApiURls.getusernotofication);

      // Send a GET request to the API
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> data = json.decode(response.body);
        print('dataa$data');
        userNotifications.value =
            data.map((item) => item as Map<String, dynamic>).toList();
        userNotifications.value = data;
        print(
            'notifications${userNotifications.value[0]['user_id'].toString()}');
      } else {
        print('Failed to load notifications: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching notifications: $error');
    }
  }
}
