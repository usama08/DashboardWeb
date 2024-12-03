import 'package:charity_life/views/beneficiary/product_view/view/single_product_view.dart';
import '../../../../enums/dependencies.dart';

class ProductsSection extends StatefulWidget {
  const ProductsSection({super.key});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  var beneficiaryController = Get.put(BeneficiaryController());
  bool isLoadingMore = false;

  void loadMoreProducts() {
    setState(() {
      isLoadingMore = true;
    });
    beneficiaryController.getProductListing().then((_) {
      setState(() {
        isLoadingMore = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Fetch filtered products based on the selected category
      // ignore: invalid_use_of_protected_member
      final products = beneficiaryController.filteredProducts.value;

      return Column(
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.65,
            ),
            itemCount: products.length + (products.length > 6 ? 1 : 0),
            itemBuilder: (context, index) {
              // Check for the "Load More" button
              if (index == products.length) {
                return isLoadingMore
                    ? const Center(child: CircularProgressIndicator())
                    : GestureDetector(
                        onTap: loadMoreProducts,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextWidget(
                            text: 'Load More',
                            size: 16,
                            fontFamily: "semi",
                            color: AppColors.whiteColor,
                          ),
                        ),
                      );
              }

              final product = products[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => SingleProductView(index: index));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.08),
                        blurRadius: 24,
                        spreadRadius: -6,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Hero(
                              tag: "productImage$index",
                              transitionOnUserGestures: true,
                              child: Image.memory(
                                base64Decode(product.productImage),
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (product.isDiscount)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                child: TextWidget(
                                  text: '${product.discountPercentage}% OFF',
                                  size: 12,
                                  fontFamily: "regular",
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: product.productName,
                              size: 12,
                              fontFamily: "regular",
                              color: AppColors.primaryDark,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text:
                                            'SAR ${product.salePrice.toStringAsFixed(2)}',
                                        size: 14,
                                        fontFamily: "semi",
                                        color: AppColors.primaryColor,
                                      ),
                                      if (product.isDiscount)
                                        Row(
                                          children: [
                                            TextWidget(
                                              text:
                                                  'SAR ${(product.salePrice / (1 - product.discountPercentage / 100)).toStringAsFixed(2)}',
                                              size: 12,
                                              fontFamily: "regular",
                                              color: AppColors.greyDark,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                            const SizedBox(width: 5),
                                            Flexible(
                                                child: TextWidget(
                                              text:
                                                  '-${product.discountPercentage}%',
                                              size: 12,
                                              fontFamily: "regular",
                                              color: AppColors.blackColor,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: AppColors.primaryColor,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
