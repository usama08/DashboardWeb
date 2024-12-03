// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool success;
  String message;
  List<UserData> data;

  UserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    success: json["success"],
    message: json["message"],
    data: List<UserData>.from(json["Data"].map((x) => UserData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserData {
  int userId;
  int titleId;
  String title;
  String firstName;
  String lastName;
  String login;
  String email;
  int groupId;
  String groupName;
  String status;

  UserData({
    required this.userId,
    required this.titleId,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.login,
    required this.email,
    required this.groupId,
    required this.groupName,
    required this.status,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    userId: json["UserID"],
    titleId: json["TitleID"],
    title: json["Title"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    login: json["Login"],
    email: json["Email"],
    groupId: json["GroupID"],
    groupName: json["GroupName"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "UserID": userId,
    "TitleID": titleId,
    "Title": title,
    "FirstName": firstName,
    "LastName": lastName,
    "Login": login,
    "Email": email,
    "GroupID": groupId,
    "GroupName": groupName,
    "Status": status,
  };
}
