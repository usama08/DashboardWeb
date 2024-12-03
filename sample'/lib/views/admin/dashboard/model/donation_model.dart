// To parse this JSON data, do
//
//     final donationsModel = donationsModelFromJson(jsonString);

import 'dart:convert';

DonationsModel donationsModelFromJson(String str) => DonationsModel.fromJson(json.decode(str));

String donationsModelToJson(DonationsModel data) => json.encode(data.toJson());

class DonationsModel {
  bool success;
  String message;
  List<DonationData> data;

  DonationsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DonationsModel.fromJson(Map<String, dynamic> json) => DonationsModel(
    success: json["success"],
    message: json["message"],
    data: List<DonationData>.from(json["Data"].map((x) => DonationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DonationData {
  int voucherId;
  dynamic distributorId;
  String voucherNo;
  DateTime voucherDate;
  dynamic voucherType;
  dynamic bankId;
  String remarks;
  double debit;
  dynamic credit;
  dynamic createdOn;
  dynamic createdBy;
  dynamic updateOn;
  dynamic updateBy;
  dynamic isPost;
  dynamic postedOn;
  dynamic postedBy;
  dynamic fiscalYearId;
  dynamic donationReceipt;
  dynamic accountId;
  String receiptImage;
  String donorName;

  DonationData({
    required this.voucherId,
    required this.distributorId,
    required this.voucherNo,
    required this.voucherDate,
    required this.voucherType,
    required this.bankId,
    required this.remarks,
    required this.debit,
    required this.credit,
    required this.createdOn,
    required this.createdBy,
    required this.updateOn,
    required this.updateBy,
    required this.isPost,
    required this.postedOn,
    required this.postedBy,
    required this.fiscalYearId,
    required this.donationReceipt,
    required this.accountId,
    required this.receiptImage,
    required this.donorName,
  });

  factory DonationData.fromJson(Map<String, dynamic> json) => DonationData(
    voucherId: json["VoucherID"],
    distributorId: json["DistributorID"],
    voucherNo: json["VoucherNo"],
    voucherDate: DateTime.parse(json["VoucherDate"]),
    voucherType: json["VoucherType"],
    bankId: json["BankID"],
    remarks: json["Remarks"],
    debit: json["Debit"],
    credit: json["Credit"],
    createdOn: json["Created_On"],
    createdBy: json["Created_By"],
    updateOn: json["Update_On"],
    updateBy: json["Update_By"],
    isPost: json["Is_Post"],
    postedOn: json["Posted_On"],
    postedBy: json["Posted_By"],
    fiscalYearId: json["FiscalYearID"],
    donationReceipt: json["DonationReceipt"],
    accountId: json["AccountID"],
    receiptImage: json["ReceiptImage"],
    donorName: json["DonorName"],
  );

  Map<String, dynamic> toJson() => {
    "VoucherID": voucherId,
    "DistributorID": distributorId,
    "VoucherNo": voucherNo,
    "VoucherDate": voucherDate.toIso8601String(),
    "VoucherType": voucherType,
    "BankID": bankId,
    "Remarks": remarks,
    "Debit": debit,
    "Credit": credit,
    "Created_On": createdOn,
    "Created_By": createdBy,
    "Update_On": updateOn,
    "Update_By": updateBy,
    "Is_Post": isPost,
    "Posted_On": postedOn,
    "Posted_By": postedBy,
    "FiscalYearID": fiscalYearId,
    "DonationReceipt": donationReceipt,
    "AccountID": accountId,
    "ReceiptImage": receiptImage,
    "DonorName": donorName,
  };
}
