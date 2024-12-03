import 'package:charity_life/enums/dependencies.dart';

AddCartValues productListingFromJson(String str) =>
    AddCartValues.fromJson(json.decode(str));

String productListingToJson(AddCartValues data) => json.encode(data.toJson());

class AddCartValues {
  final bool success;
  final String message;

  // Constructor for the model class
  AddCartValues({required this.success, required this.message});

  factory AddCartValues.fromJson(Map<String, dynamic> json) {
    return AddCartValues(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  // Method to convert the model instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'AddCartValues(success: $success, message: "$message")';
  }
}
