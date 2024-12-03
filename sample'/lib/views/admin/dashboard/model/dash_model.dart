// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  bool success;
  String message;
  Data data;

  DashboardModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "Data": data.toJson(),
  };
}

class Data {
  String totalDonations;
  double growthRateDonation;
  List<InvenInventoryLevel> invenInventoryLevels;

  Data({
    required this.totalDonations,
    required this.growthRateDonation,
    required this.invenInventoryLevels,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalDonations: json["TotalDonations"],
    growthRateDonation: json["GrowthRateDonation"],
    invenInventoryLevels: List<InvenInventoryLevel>.from(json["InvenInventoryLevels"].map((x) => InvenInventoryLevel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalDonations": totalDonations,
    "GrowthRateDonation": growthRateDonation,
    "InvenInventoryLevels": List<dynamic>.from(invenInventoryLevels.map((x) => x.toJson())),
  };
}

class InvenInventoryLevel {
  int value;
  String category;

  InvenInventoryLevel({
    required this.value,
    required this.category,
  });

  factory InvenInventoryLevel.fromJson(Map<String, dynamic> json) => InvenInventoryLevel(
    value: json["value"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "category": category,
  };
}
