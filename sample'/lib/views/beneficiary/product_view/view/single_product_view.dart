import '../../../../enums/dependencies.dart';
import '../../myCart/view/addtto_Cart.dart';
import '../controller/product_view.dart';

class SingleProductView extends StatefulWidget {
  final int index;
  const SingleProductView({super.key, required this.index});

  @override
  State<SingleProductView> createState() => _ProductSelectionState();
}

class _ProductSelectionState extends State<SingleProductView> {
  final beneficiaryController = Get.put(BeneficiaryController());
  final productViewController = Get.put(PrdductViewAdd());

  @override
  Widget build(BuildContext context) {
    var product = beneficiaryController.productListing.value.data[widget.index];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: "productImage${widget.index}",
                    transitionOnUserGestures: true,
                    child: Image.memory(
                      base64Decode(product.productImage),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.circle),
                          child: HeroIcon(
                            HeroIcons.chevronLeft,
                            color: AppColors.primaryDark,
                            style: HeroIconStyle.solid,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const AddCart()),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.circle),
                          child: HeroIcon(
                            HeroIcons.shoppingCart,
                            color: AppColors.primaryDark,
                            style: HeroIconStyle.solid,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: product.productName,
                    size: 24,
                    fontFamily: "bold",
                    color: AppColors.primaryDark,
                  ),
                  TextWidget(
                    text: product.unit.isNotEmpty
                        ? '${product.unit} per item'
                        : 'No description available',
                    size: 16,
                    fontFamily: "regular",
                    color: AppColors.primaryDark.withOpacity(0.6),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'SAR ${product.salePrice}',
                            size: 20,
                            fontFamily: "bold",
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.start,
                          ),
                          if (product.isDiscount) ...[
                            Row(
                              children: [
                                TextWidget(
                                  text:
                                      'SAR ${product.discountAmount.toStringAsFixed(2)}',
                                  size: 14,
                                  fontFamily: "regular",
                                  color: AppColors.greyDark,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                const SizedBox(width: 5),
                                TextWidget(
                                  text: '-${product.discountPercentage}%',
                                  size: 14,
                                  fontFamily: "bold",
                                  color: AppColors.primaryDark,
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Availability',
                            size: 16,
                            fontFamily: "regular",
                            color: AppColors.primaryDark.withOpacity(0.6),
                          ),
                          TextWidget(
                            text: 'In Stock',
                            size: 14,
                            fontFamily: "bold",
                            color: AppColors.primaryDark,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 130,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: -6,
                                color: AppColors.blackColor.withOpacity(0.08),
                                blurRadius: 24),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (productViewController.quantity.value > 1) {
                                  await productViewController.quantitycheck(
                                    context,
                                    product.supplierId,
                                    product.productId,
                                    productViewController.quantity.value,
                                  );
                                  if (productViewController.reponseto.value ==
                                      'ok') {
                                    productViewController.quantity.value--;
                                  }
                                }
                              },
                              child: HeroIcon(
                                HeroIcons.minus,
                                style: HeroIconStyle.solid,
                                color: productViewController.quantity.value == 1
                                    ? const Color(0xFFB4B8C0)
                                    : AppColors.primaryDark,
                                size: 22,
                              ),
                            ),
                            Obx(() => TextWidget(
                                text: '${productViewController.quantity.value}',
                                size: 16,
                                fontFamily: "semi",
                                color: AppColors.primaryDark)),
                            GestureDetector(
                              onTap: () async {
                                await productViewController.quantitycheck(
                                  context,
                                  product.supplierId,
                                  product.productId,
                                  productViewController.quantity.value + 1,
                                );
                                if (productViewController.reponseto.value ==
                                    'ok') {
                                  productViewController.quantity.value++;
                                }
                              },
                              child: HeroIcon(
                                HeroIcons.plus,
                                color: AppColors.primaryDark,
                                style: HeroIconStyle.solid,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyFancyButton(
                          isIconButton: false,
                          fontSize: 16,
                          family: "OpenSans-SemiBold",
                          fontColor: AppColors.whiteColor,
                          text:
                              'Add SAR ${(product.salePrice * productViewController.quantity.value).toStringAsFixed(2)}',
                          tap: () {
                            productViewController.addcart(
                              context,
                              product.supplierId,
                              product.productId,
                              product.salePrice,
                              product.isDiscount,
                              product.discountPercentage,
                              product.discountAmount,
                              productViewController.quantity.value,
                            );
                          },
                          borderRadius: 100,
                          height: 50,
                          buttonColor: AppColors.primaryColor,
                          hasShadow: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: MyFancyButton(
                      isIconButton: false,
                      fontSize: 16,
                      family: "OpenSans-Bold",
                      fontColor: AppColors.primaryColor,
                      text: 'Buy Now',
                      tap: () {
                        productViewController.addcart(
                            context,
                            product.supplierId,
                            product.productId,
                            product.salePrice,
                            product.isDiscount,
                            product.discountPercentage,
                            product.discountAmount,
                            productViewController.quantity.value);
                      },
                      borderRadius: 100,
                      borderColor: AppColors.primaryColor,
                      height: 50,
                      buttonColor: AppColors.whiteColor,
                      hasShadow: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
