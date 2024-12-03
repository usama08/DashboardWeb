import 'dart:convert';
import 'package:dashboarweb/services/Api/allApies.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Auth/controller/authcontroller.dart';
import '../model/policyget_model.dart';

class AppController extends GetxController {
  var authControler = Get.put(AuthController());

  RxList<InsurancePolicy> allpolicy =
      <InsurancePolicy>[].obs; // Global observable list
  RxList<dynamic> chatReceived = <dynamic>[].obs;

  Future<void> insurancePolicy() async {
    print('id${authControler.userData.value['UserID']}');
    final url = Uri.parse(
        'http://127.0.0.1:3000/userinsurancepolicies?userID=${authControler.userData.value['UserID']}'); // Replace with your server address

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('response$data');
        // Map the response data to the list
        allpolicy.value =
            data.map((json) => InsurancePolicy.fromJson(json)).toList();

        allpolicy.value[0].insuranceName;
        print('insurancename${allpolicy.value[0].insuranceName.toString()}');
      } else {
        print(
            'Error: Failed to fetch insurance policies. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: Failed to fetch insurance policies - $error');
    }
  }

  ///----------------------------  Chat Post -------------------------///
  Future<void> sendMessageToAdmin(
      String userId, String message, bool isAdmin) async {
    final String url = '${ApiURls.sendmesage}';
    print('Sending message to userId: $userId, isAdmin: $isAdmin');

    // Prepare the data to be sent, including `isAdmin`
    Map<String, dynamic> requestBody = {
      'userId': userId.toString(),
      'message': message,
      'isAdmin': isAdmin,
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
        print('Message sent successfully: ${responseData['message']}');
        Get.snackbar("Success", responseData['message']);
      } else {
        var responseData = jsonDecode(response.body);
        print('Failed to send message. Error: ${responseData['error']}');
        Get.snackbar("Error", responseData['error']);
      }
    } catch (error) {
      print('Error during API request: $error');
      Get.snackbar("Error", "Internal Server Error");
    }
  }

  /// -----------------------  Chat Received ----------------------- ///
  Future<void> chat(String userId) async {
    final String url =
        '${ApiURls.getmesage}?userId=$userId'; // Append userId as a query parameter

    try {
      // Send a GET request to fetch messages
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Decode and update the global RxList with received messages
        List<dynamic> messages = jsonDecode(response.body);
        chatReceived.assignAll(messages);
        print('Messages received successfully');
      } else {
        print(
            'Failed to retrieve messages. Status code: ${response.statusCode}');
        Get.snackbar("Error", "Failed to retrieve messages");
      }
    } catch (error) {
      print('Error during API request: $error');
      Get.snackbar("Error", "Internal Server Error");
    }
  }
}
