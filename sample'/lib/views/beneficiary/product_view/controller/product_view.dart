import 'package:charity_life/enums/dependencies.dart';

import '../../myCart/view/addtto_Cart.dart';

class PrdductViewAdd extends GetxController {
  APIService apiService = APIService();
  var loginController = Get.put(AuthController());
  RxInt quantity = 1.obs;
  var reponseto = ''.obs;
  var isLoading = false.obs;

  /// -------------------  Add to Cart Function -------------------------- ///
  ///
  ///
  ///
  ///
  Future<void> addcart(context, supplierId, productId, salePrice, isDiscount,
      discountPercentage, discountAmount, qty) async {
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

    apiService
        .postAddcart(loginController.loginData.userId, supplierId, productId,
            salePrice, isDiscount, discountPercentage, discountAmount, qty)
        .then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        BotToast.closeAllLoading();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const DialogBox(
              heading: 'Successful!',
              body: 'Products add successfully.',
            );
          },
        );
        // ignore: prefer_const_constructors
        Get.to(AddCart());
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        BotToast.showSimpleNotification(
            title: json.decode(response.body)["message"],
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogBox(
              type: "Error",
              heading: 'Products add  Failed!',
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

  /// --------------------- Check Quantity ----------------------- ///
  Future<void> quantitycheck(context, supplierId, productId, qty) async {
    print(
        "UserId: ${loginController.loginData.userId}, SupplierId: $supplierId, ProductId: $productId, Quantity: $qty");
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

    apiService
        .postQuantitycheck(
            loginController.loginData.userId, supplierId, productId, qty)
        .then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        reponseto.value = 'ok';
        BotToast.closeAllLoading();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const DialogBox(
              heading: 'Successful!',
              body: 'Products add.',
            );
          },
        );
        // ignore: prefer_const_constructors
        Get.to(AddCart());
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        BotToast.showSimpleNotification(
            title: json.decode(response.body)["message"],
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogBox(
              type: "Error",
              heading: 'Products add Failed!',
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
