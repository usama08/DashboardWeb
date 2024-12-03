// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool success;
  String message;
  LoginData data;

  LoginModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        data: LoginData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": data.toJson(),
      };
}

class LoginData {
  int userId;
  String fullName;
  String email;
  String address1;
  String address2;
  String phone;
  dynamic gender;
  bool active;
  int groupId;
  String group;
  int countryId;
  String country;
  String province;
  int provinceId;
  int cityId;
  String city;
  String vehicleType;
  String vehicleRegistrationNo;

  LoginData({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.address1,
    required this.address2,
    required this.phone,
    required this.gender,
    required this.active,
    required this.groupId,
    required this.group,
    required this.countryId,
    required this.country,
    required this.province,
    required this.provinceId,
    required this.cityId,
    required this.city,
    required this.vehicleType,
    required this.vehicleRegistrationNo,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        userId: json["UserID"],
        fullName: json["FullName"],
        email: json["Email"],
        address1: json["Address1"],
        address2: json["Address2"] ?? '',
        phone: json["Phone"],
        gender: json["Gender"],
        active: json["Active"],
        groupId: json["GroupID"],
        group: json["Group"],
        countryId: json["CountryID"],
        country: json["Country"],
        province: json["Province"],
        provinceId: json["ProvinceID"],
        cityId: json["CityID"],
        city: json["City"],
        vehicleType: json["VehicleType"],
        vehicleRegistrationNo: json["VehicleRegistrationNo"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": userId,
        "FullName": fullName,
        "Email": email,
        "Address1": address1,
        "Address2": address2,
        "Phone": phone,
        "Gender": gender,
        "Active": active,
        "GroupID": groupId,
        "Group": group,
        "CountryID": countryId,
        "Country": country,
        "Province": province,
        "ProvinceID": provinceId,
        "CityID": cityId,
        "City": city,
        "VehicleType": vehicleType,
        "VehicleRegistrationNo": vehicleRegistrationNo,
      };
}
