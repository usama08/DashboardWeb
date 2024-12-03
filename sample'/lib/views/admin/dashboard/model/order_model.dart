// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  int cid;
  int beneficiaryId;
  DateTime orderDate;
  String orderNo;
  int statusId;
  double paidAmount;
  bool isPaid;
  dynamic createdBy;
  dynamic createdOn;
  dynamic modifiedBy;
  dynamic modifiedOn;
  dynamic assignBy;
  dynamic assingDate;
  int? volunteerId;
  dynamic deliveredBy;
  dynamic deliveredDate;
  dynamic dispatchBy;
  dynamic dispatchDate;
  String fullName;
  String phone;
  String address1;
  String address2;
  String beneficiaryName;
  String deliveryName;
  String deliveryPhone;
  String status;
  int orderType;
  List<ProceedPorduct> proceedPorduct;

  OrderModel({
    required this.cid,
    required this.beneficiaryId,
    required this.orderDate,
    required this.orderNo,
    required this.statusId,
    required this.paidAmount,
    required this.isPaid,
    required this.createdBy,
    required this.createdOn,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.assignBy,
    required this.assingDate,
    required this.volunteerId,
    required this.deliveredBy,
    required this.deliveredDate,
    required this.dispatchBy,
    required this.dispatchDate,
    required this.fullName,
    required this.phone,
    required this.address1,
    required this.address2,
    required this.beneficiaryName,
    required this.deliveryName,
    required this.deliveryPhone,
    required this.status,
    required this.orderType,
    required this.proceedPorduct,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    cid: json["CID"],
    beneficiaryId: json["BeneficiaryID"],
    orderDate: DateTime.parse(json["OrderDate"]),
    orderNo: json["OrderNo"],
    statusId: json["StatusID"],
    paidAmount: json["PaidAmount"],
    isPaid: json["IsPaid"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"],
    modifiedBy: json["ModifiedBy"],
    modifiedOn: json["ModifiedOn"],
    assignBy: json["AssignBy"],
    assingDate: json["AssingDate"],
    volunteerId: json["VolunteerID"],
    deliveredBy: json["DeliveredBy"],
    deliveredDate: json["DeliveredDate"],
    dispatchBy: json["DispatchBy"],
    dispatchDate: json["DispatchDate"],
    fullName: json["FullName"],
    phone: json["Phone"],
    address1: json["Address1"],
    address2: json["Address2"],
    beneficiaryName: json["BeneficiaryName"],
    deliveryName: json["DeliveryName"],
    deliveryPhone: json["DeliveryPhone"],
    status: json["Status"],
    orderType: json["OrderType"],
    proceedPorduct: List<ProceedPorduct>.from(json["ProceedPorduct"].map((x) => ProceedPorduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CID": cid,
    "BeneficiaryID": beneficiaryId,
    "OrderDate": orderDate.toIso8601String(),
    "OrderNo": orderNo,
    "StatusID": statusId,
    "PaidAmount": paidAmount,
    "IsPaid": isPaid,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn,
    "ModifiedBy": modifiedBy,
    "ModifiedOn": modifiedOn,
    "AssignBy": assignBy,
    "AssingDate": assingDate,
    "VolunteerID": volunteerId,
    "DeliveredBy": deliveredBy,
    "DeliveredDate": deliveredDate,
    "DispatchBy": dispatchBy,
    "DispatchDate": dispatchDate,
    "FullName": fullName,
    "Phone": phone,
    "Address1": address1,
    "Address2": address2,
    "BeneficiaryName": beneficiaryName,
    "DeliveryName": deliveryName,
    "DeliveryPhone": deliveryPhone,
    "Status": status,
    "OrderType": orderType,
    "ProceedPorduct": List<dynamic>.from(proceedPorduct.map((x) => x.toJson())),
  };
}


class ProceedPorduct {
  int detailCid;
  int cid;
  int supplierId;
  int productId;
  int qty;
  bool isDiscount;
  int discountPercentage;
  double discountAmount;
  double salePrice;
  dynamic createdBy;
  dynamic createdOn;
  dynamic modifiedBy;
  dynamic modifiedOn;
  String categoryName;
  String subCategoryName;
  String productCode;
  String productName;
  String unit;
  dynamic productImage;
  String productImageBase64;

  ProceedPorduct({
    required this.detailCid,
    required this.cid,
    required this.supplierId,
    required this.productId,
    required this.qty,
    required this.isDiscount,
    required this.discountPercentage,
    required this.discountAmount,
    required this.salePrice,
    required this.createdBy,
    required this.createdOn,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.categoryName,
    required this.subCategoryName,
    required this.productCode,
    required this.productName,
    required this.unit,
    required this.productImage,
    required this.productImageBase64,
  });

  factory ProceedPorduct.fromJson(Map<String, dynamic> json) => ProceedPorduct(
    detailCid: json["Detail_CID"],
    cid: json["CID"],
    supplierId: json["SupplierID"],
    productId: json["ProductID"],
    qty: json["Qty"],
    isDiscount: json["IsDiscount"],
    discountPercentage: json["DiscountPercentage"],
    discountAmount: json["DiscountAmount"]?.toDouble(),
    salePrice: json["SalePrice"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"],
    modifiedBy: json["ModifiedBy"],
    modifiedOn: json["ModifiedOn"],
    categoryName: json["CategoryName"],
    subCategoryName: json["SubCategoryName"],
    productCode: json["ProductCode"],
    productName: json["ProductName"],
    unit: json["Unit"],
    productImage: json["ProductImage"],
    productImageBase64: json["ProductImageBase64"],
  );

  Map<String, dynamic> toJson() => {
    "Detail_CID": detailCid,
    "CID": cid,
    "SupplierID": supplierId,
    "ProductID": productId,
    "Qty": qty,
    "IsDiscount": isDiscount,
    "DiscountPercentage": discountPercentage,
    "DiscountAmount": discountAmount,
    "SalePrice": salePrice,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn,
    "ModifiedBy": modifiedBy,
    "ModifiedOn": modifiedOn,
    "CategoryName": categoryName,
    "SubCategoryName": subCategoryName,
    "ProductCode": productCode,
    "ProductName": productName,
    "Unit": unit,
    "ProductImage": productImage,
    "ProductImageBase64": productImageBase64,
  };
}

