//ignore_for_file: depend_on_referenced_packages
import "dart:io";
import "package:charity_life/service/exception_handle.dart";
import "package:http/http.dart" as http;
import "../enums/dependencies.dart";

class APIService {
  static const String baseURL = "http://192.168.5.245/UTSCMSAPI/API/";
  static const String login = "Authentication/Login";
  static const String sendOTP = "Authentication/SentOTP";
  static const String userApprove = "Authentication/ActiveUsers";
  static const String pendingUsers = "Authentication/GetPendingUsersApproval";
  static const String otpVerify = "Authentication/VerifyOTP";
  static const String resetPassword = "Authentication/ResetPassword";
  static const String adminDashboard = "Dashboard/AdminDashboard";
  static const String getOrders = "Orders/GetOrders";
  static const String getDonations = "Donation/GetDonations";
  static const String donationPost = "Donation/PostDonation";
  static const String prductliting = "ProductList";
  static const String addcart = "AddToCart";
  static const String quantitycheck = "CheckQuantity";

  ////////////////////////EXCEPTION CHECKER
  Future<http.Response?> getAPIData(
      {required String url,
      required bool isPost,
      Map<String, dynamic>? body}) async {
    bool shouldRetry = true;
    while (shouldRetry) {
      try {
        final response = isPost && body != null
            ? await http.post(Uri.parse(url),
                body: json.encode(body),
                headers: {'Content-Type': 'application/json'})
            : isPost && body == null
                ? await http.post(Uri.parse(url))
                : await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          return response;
        } else {
          switch (response.statusCode) {
            case 403:
              throw ForbiddenException();
            case 404:
              throw NotFoundException();
            case 409:
              throw ConflictException();
            case 500:
              throw InternalServerErrorException();
            case 503:
              throw ServiceUnavailableException();
            default:
              throw MyException();
          }
        }
      } on SocketException {
        BotToast.showSimpleNotification(
            title:
                "No internet connection. Please connect to a network and try again.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on http.ClientException {
        BotToast.showSimpleNotification(
            title:
                "Oops! There seems to be an issue with the request. Please check and try again.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on HttpException {
        BotToast.showSimpleNotification(
            title:
                "Something went wrong with the server. Please try again later.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on FormatException {
        BotToast.showSimpleNotification(
            title:
                "Unable to process the input due to an invalid format. Please ensure everything is entered correctly.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on TimeoutException {
        BotToast.showSimpleNotification(
            title: "The request timed out. Please try again later.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on ForbiddenException {
        BotToast.showSimpleNotification(
            title:
                "Access to this feature is restricted. Please check your permissions or contact support for help.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on NotFoundException {
        BotToast.showSimpleNotification(
            title:
                "The resource you're looking for could not be found. Please check the URL or try again later.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on ConflictException {
        BotToast.showSimpleNotification(
            title:
                "There was a conflict with your request. Please try again or contact support.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on InternalServerErrorException {
        BotToast.showSimpleNotification(
            title: "The server encountered an error. Please try again later.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on ServiceUnavailableException {
        BotToast.showSimpleNotification(
            title:
                "The service is currently unavailable. Please try again in a few minutes.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on MyException {
        BotToast.showSimpleNotification(
            title:
                "Something went wrong. Please check your internet and try again.",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      } on ApiException {
        BotToast.showSimpleNotification(
            title: "API Exception",
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
      }
      return null;
    }
  }

  ////////////////////////LOGIN USER API
  Future<http.Response?> loginUser(email, password) async {
    final response = getAPIData(
        url: '$baseURL$login?Email=$email&Password=$password', isPost: false);
    return response;
  }

  ////////////////////////SENT OTP API
  Future<http.Response?> sendOTPUser(email) async {
    final response =
        getAPIData(url: '$baseURL$sendOTP?Email=$email', isPost: true);
    return response;
  }

  ////////////////////////VERIFY OTP API
  Future<http.Response?> verifyOTP(email, otp) async {
    final response = getAPIData(
        url: '$baseURL$otpVerify?Email=$email&OTP=$otp', isPost: true);
    return response;
  }

  ////////////////////////RESET PASSWORD API
  Future<http.Response?> resetPass(email, password) async {
    final response = getAPIData(
        url: '$baseURL$resetPassword?Email=$email&Password=$password',
        isPost: true);
    return response;
  }

  ////////////////////////DASHBOARD API
  Future<http.Response?> dashboardData() async {
    final response = getAPIData(url: '$baseURL$adminDashboard', isPost: false);
    return response;
  }

  ////////////////////////ORDERS API
  Future<http.Response?> getOrderData(groupID) async {
    final response = getAPIData(
        url: '$baseURL$getOrders?StatusID=0&GroupID=$groupID', isPost: false);
    return response;
  }

  ////////////////////////DONATIONS API
  Future<http.Response?> donationsData() async {
    final response = getAPIData(url: '$baseURL$getDonations', isPost: false);
    return response;
  }

  ////////////////////////PENDING USERS API
  Future<http.Response?> getPendingUsers() async {
    final response = getAPIData(url: '$baseURL$pendingUsers', isPost: false);
    return response;
  }

  ////////////////////////POST DONATIONS API
  Future<http.Response?> postDonation(userID, voucherIDs) async {
    final response = getAPIData(
        url: '$baseURL$donationPost',
        isPost: true,
        body: {"UserID": userID, "VoucherIDs": voucherIDs});
    return response;
  }

  ////////////////////////APPROVE USERS API
  Future<http.Response?> approveUser(userID, userIDs) async {
    final response = getAPIData(
        url: '$baseURL$userApprove',
        isPost: true,
        body: {"UpdatedBy": userID, "UserIDs": userIDs});

    return response;
  }

////////////////////////LOGIN USER API
  Future<http.Response?> getProductlisting(groupID, userID) async {
    final response = getAPIData(
        url: '$baseURL$prductliting?GroupID=$groupID&UserID=$userID',
        isPost: false);
    return response;
  }

  /// --  Add TO Cart -- //
  Future<http.Response?> postAddcart(userID, supplierID, productID, salePrice,
      isDiscount, discountPercentage, discountAmount, qty) async {
    final response = getAPIData(url: '$baseURL$addcart', isPost: true, body: {
      "UserID": userID,
      "SupplierID": supplierID,
      "ProductID": productID,
      "SalePrice": salePrice,
      "IsDiscount": isDiscount,
      "DiscountPercentage": discountPercentage,
      "DiscountAmount": discountAmount,
      "Qty": qty,
    });
    return response;
  }

  /// --  Check quantity -- //
  Future<http.Response?> postQuantitycheck(
      userID, supplierID, productID, qty) async {
    final response =
        getAPIData(url: '$baseURL$quantitycheck', isPost: false, body: {
      "UserID": userID,
      "SupplierID": supplierID,
      "ProductID": productID,
      "Qty": qty,
    });
    return response;
  }
}
