import 'package:charity_life/enums/dependencies.dart';

import '../model/product_listing.dart';

class BeneficiaryController extends GetxController {
  APIService apiService = APIService();
  var loginController = Get.put(AuthController());
  var selectedCategory = 0.obs;
// Function to filter products by category
// Function to filter products by category ID
  void filterProductsByCategory(int categoryId) {
    selectedCategory.value = categoryId;
    if (categoryId == 0) {
      filteredProducts.value = productListing.value.data;
    } else {
      filteredProducts.value = productListing.value.data
          .where((product) => product.categoryId == categoryId)
          .toList();
    }
  }

  TextEditingController search = TextEditingController();

  final List<Product> products = [
    Product(
        imagePath: AppImages.product1,
        name: 'Nestle Koko Krunch Chocolate',
        price: 45.50,
        discount: 2.5),
    Product(
        imagePath: AppImages.product2,
        name: 'Sasso Olive Oil 100% Pure',
        price: 25.50,
        discount: 0),
    Product(
        imagePath: AppImages.product1,
        name: 'Nestle Koko Krunch Chocolate',
        price: 15.50,
        discount: 0),
    Product(
        imagePath: AppImages.product2,
        name: 'Sasso Olive Oil 100% Pure',
        price: 22.50,
        discount: 2.5),
  ];

  final categories = [
    Category(imagePath: AppImages.grocery, label: "Grocery"),
    Category(imagePath: AppImages.pharmacy, label: "Pharmacy"),
    Category(imagePath: AppImages.gifting, label: "Gifting"),
    Category(imagePath: AppImages.beverages, label: "Beverages"),
    Category(imagePath: AppImages.stationary, label: "Stationary"),
    Category(imagePath: AppImages.healthBeauty, label: "Health & Beauty"),
    Category(imagePath: AppImages.houseCleaning, label: "House Cleaning"),
    Category(imagePath: AppImages.other, label: "More"),
  ];
  // ---------------------   Product Lisitng ------------------------ //
  var productListing = Rx<ProductListing>(ProductListing(
      success: false, message: '', accountBalance: 0.0, data: []));
  var filteredProducts = <ProductData>[].obs;

  var isLoading = false.obs;

  Future<void> getProductListing() async {
    isLoading.value = true;
    update();
    try {
      final response = await apiService.getProductlisting(
        loginController.loginData.groupId,
        loginController.loginData.userId,
      );

      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse["success"] == true) {
          productListing.value = ProductListing.fromJson(jsonResponse);

          // Set filteredProducts to all products by default
          filteredProducts.value = productListing.value.data;
        } else {
          productListing.value = ProductListing(
            success: false,
            message: jsonResponse["message"] ?? "Error",
            accountBalance: 0.0,
            data: [],
          );
        }
      }
    } catch (error) {
      productListing.value = ProductListing(
        success: false,
        message: "Failed to load data",
        accountBalance: 0.0,
        data: [],
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
