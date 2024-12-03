import 'package:charity_life/enums/dependencies.dart';
import 'package:charity_life/views/beneficiary/dashboard/beneficiary_dashboard.dart';

class AuthController extends GetxController {
  APIService apiService = APIService();
  TextEditingController emailController = TextEditingController();
  TextEditingController forgetEmail = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  var pass = true.obs;
  togglePassword() {
    pass.value = !pass.value;
    update();
  }

  var pass2 = true.obs;
  togglePassword2() {
    pass2.value = !pass2.value;
    update();
  }

  var pass3 = true.obs;
  togglePassword3() {
    pass3.value = !pass3.value;
    update();
  }

  var rememberMe = false.obs;

  ////////// HANDLE REMEMBER ME FUNCTION \\\\\\\\\\
  void handleRememberMe(bool? value) async {
    SharedPref.saveRememberMe(value!);

    rememberMe.value = !rememberMe.value;
    update();

    if (value == true) {
      SharedPref.saveEmail(emailController.text);
      SharedPref.saveUserPassword(passController.text);
    } else {
      SharedPref.saveEmail("");
      SharedPref.saveUserPassword("");
    }
  }

  ////////// LOAD USER AND PASSWORD \\\\\\\\\\
  void loadUserEmailPassword() async {
    var username = await SharedPref.getEmail();
    var password2 = await SharedPref.getUserPassword();
    var rememberMe2 = await SharedPref.getRememberMe();

    if (rememberMe2 != null && rememberMe2 == true) {
      rememberMe.value = true;
      emailController.text = username.toString();
      passController.text = password2.toString();
      update();
    } else {
      rememberMe.value = false;
      emailController.text = "";
      passController.text = "";
      update();
    }
  }

  late LoginData loginData;
  ////////// LOGIN USER \\\\\\\\\\
  Future<void> userLogin(context) async {
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    var email = Uri.encodeComponent(emailController.text.toString().trim());
    var password = Uri.encodeComponent(passController.text.toString().trim());

    apiService.loginUser(email, password).then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        loginData = LoginData.fromJson(json.decode(response.body)["Data"]);
        update();
        BotToast.closeAllLoading();
        if (json.decode(response.body)["Data"]["Group"] == "Admin") {
          //ADMIN DASHBOARD
          Get.offAll(() => const Dashboard());
        } else if (json.decode(response.body)["Data"]["Group"] == "Delivery") {
          //DELIVERY DASHBOARD
        } else if (json.decode(response.body)["Data"]["Group"] == "Supplier") {
          //SUPPLIER DASHBOARD
        } else if (json.decode(response.body)["Data"]["Group"] ==
            "Beneficiary") {
          //BENEFICIARY DASHBOARD
          Get.offAll(() => const BeneficiaryDashboard());
        } else if (json.decode(response.body)["Data"]["Group"] == "Donor") {
          //DONOR DASHBOARD
        } else if (json.decode(response.body)["Data"]["Group"] ==
            "Supplier Admin") {
          //SUPPLIER ADMIN DASHBOARD
        } else {}
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogBox(
              type: "Error",
              heading: 'Login Failed!',
              body: json.decode(response.body)["message"],
            );
          },
        );
        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    });
  }

  ////////// SEND OTP USER \\\\\\\\\\
  Future<void> sendOTP(context) async {
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    var email = Uri.encodeComponent(forgetEmail.text.toString().trim());

    apiService.sendOTPUser(email).then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        BotToast.showSimpleNotification(
            title: json.decode(response.body)["message"],
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.green);

        Future.delayed(const Duration(seconds: 1), () {
          BotToast.closeAllLoading();
          Get.to(() => const OtpScreen());
        });
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogBox(
              type: "Error",
              heading: 'OTP Sent Failed!',
              body: json.decode(response.body)["message"],
            );
          },
        );
        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    });
  }

  ////////// VERIFY OTP USER \\\\\\\\\\
  Future<void> verifyOTP(context) async {
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    var email = Uri.encodeComponent(forgetEmail.text.toString().trim());
    var otp = otpController.text.toString();

    apiService.verifyOTP(email, otp).then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        BotToast.showSimpleNotification(
            title: json.decode(response.body)["message"],
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.green);
        Future.delayed(const Duration(seconds: 1), () {
          BotToast.closeAllLoading();
          Get.offAll(() => NewPassword(email: forgetEmail.text));
        });
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogBox(
              type: "Error",
              heading: 'OTP Verification Failed!',
              body: json.decode(response.body)["message"],
            );
          },
        );
        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    });
  }

  ////////// RESET USER PASSWORD \\\\\\\\\\
  Future<void> resetPassword(email2, context) async {
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    var email = Uri.encodeComponent(email2.toString().trim());
    var password = Uri.encodeComponent(newPass.text.toString().trim());

    apiService.resetPass(email, password).then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        BotToast.showSimpleNotification(
            title: json.decode(response.body)["message"],
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.green);
        SharedPref.saveUserPassword(newPass.text);
        Future.delayed(const Duration(seconds: 1), () {
          BotToast.closeAllLoading();
          Get.offAll(() => const LoginScreen());
        });
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogBox(
              type: "Error",
              heading: 'Password Reset Failed!',
              body: json.decode(response.body)["message"],
            );
          },
        );
        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    });
  }
}
