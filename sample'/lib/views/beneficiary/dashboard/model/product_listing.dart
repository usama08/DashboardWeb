import 'dart:convert';
import 'package:charity_life/enums/dependencies.dart';

ProductListing productListingFromJson(String str) =>
    ProductListing.fromJson(json.decode(str));

String productListingToJson(ProductListing data) => json.encode(data.toJson());

class ProductListing {
  final bool success;
  final String message;
  final double accountBalance;
  final List<ProductData> data;

  ProductListing({
    required this.success,
    required this.message,
    required this.accountBalance,
    required this.data,
  });

  factory ProductListing.fromJson(Map<String, dynamic> json) {
    try {
      return ProductListing(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        accountBalance: (json['AccountBalance'] ?? 0).toDouble(),
        data: List<ProductData>.from(
          (json['Data'] ?? []).map((item) => ProductData.fromJson(item)),
        ),
      );
    } catch (e) {
      throw Exception("Error parsing ProductListing JSON: $e");
    }
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "AccountBalance": accountBalance,
        "Data": data.map((item) => item.toJson()).toList(),
      };
}

class ProductData {
  final int rid;
  final int supplierId;
  final int productId;
  final int categoryId;
  final int subCategoryId;
  final double basePrice;
  final bool isDiscount;
  final int discountPercentage;
  final double discountAmount;
  final double salePrice;
  final String categoryName;
  final String subCategoryName;
  final String productCode;
  final String productName;
  final String unit;
  final String productImage;

  ProductData({
    required this.rid,
    required this.supplierId,
    required this.productId,
    required this.categoryId,
    required this.subCategoryId,
    required this.basePrice,
    required this.isDiscount,
    required this.discountPercentage,
    required this.discountAmount,
    required this.salePrice,
    required this.categoryName,
    required this.subCategoryName,
    required this.productCode,
    required this.productName,
    required this.unit,
    required this.productImage,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    try {
      return ProductData(
        rid: json['RID'] ?? 0,
        supplierId: json['SupplierID'] ?? 0,
        productId: json['ProductID'] ?? 0,
        categoryId: json['CategoryID'] ?? 0,
        subCategoryId: json['SubCategoryID'] ?? 0,
        basePrice: (json['BasePrice'] ?? 0).toDouble(),
        isDiscount: json['IsDiscount'] ?? false,
        discountPercentage: json['DiscountPercentage'] ?? 0,
        discountAmount: (json['DiscountAmount'] ?? 0).toDouble(),
        salePrice: (json['SalePrice'] ?? 0).toDouble(),
        categoryName: json['CategoryName'] ?? '',
        subCategoryName: json['SubCategoryName'] ?? '',
        productCode: json['ProductCode'] ?? '',
        productName: json['ProductName'] ?? '',
        unit: json['Unit'] ?? '',
        productImage: json['ProductImage'] ?? '',
      );
    } catch (e) {
      throw Exception("Error parsing ProductData JSON: $e");
    }
  }

  Map<String, dynamic> toJson() => {
        "RID": rid,
        "SupplierID": supplierId,
        "ProductID": productId,
        "CategoryID": categoryId,
        "SubCategoryID": subCategoryId,
        "BasePrice": basePrice,
        "IsDiscount": isDiscount,
        "DiscountPercentage": discountPercentage,
        "DiscountAmount": discountAmount,
        "SalePrice": salePrice,
        "CategoryName": categoryName,
        "SubCategoryName": subCategoryName,
        "ProductCode": productCode,
        "ProductName": productName,
        "Unit": unit,
        "ProductImage": productImage,
      };
}
