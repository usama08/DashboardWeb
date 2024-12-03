// ignore_for_file: file_names
import '../../../../enums/dependencies.dart';
import '../../checkOut/view/check_outScreen.dart';

class AddCart extends StatefulWidget {
  const AddCart({super.key});

  @override
  State<AddCart> createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
            color: AppColors.blackColor,
            size: 24,
            style: HeroIconStyle.solid,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const TextWidget(
          text: 'My Cart',
          size: 20,
          fontFamily: 'bold',
          color: Colors.black,
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 110,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.addtocart,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 110,
                      height: 130,
                      child: Image.asset(
                        AppImages.cartproduct,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Koko Krunch',
                        size: 16,
                        fontFamily: 'bold',
                        color: AppColors.blackColor,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      TextWidget(
                        text: '300g Pack',
                        size: 14,
                        fontFamily: 'regular',
                        color: AppColors.greyLight.withOpacity(0.7),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 60),
                      Container(
                        width: 120,
                        height: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.addtocart),
                        child: Row(
                          children: [
                            IconButton(
                              icon: HeroIcon(
                                HeroIcons.minus,
                                color: AppColors.blackColor,
                                size: 22,
                                style: HeroIconStyle.solid,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(width: 5),
                            TextWidget(
                              text: '$quantity',
                              size: 16,
                              fontFamily: 'semi',
                              color: AppColors.primaryDark,
                              textAlign: TextAlign.start,
                            ),

                            // ignore: prefer_const_constructors
                            SizedBox(width: 5),
                            IconButton(
                              icon: HeroIcon(
                                HeroIcons.plus,
                                color: AppColors.blackColor,
                                size: 22,
                                style: HeroIconStyle.solid,
                              ),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextWidget(
                  text: 'SAR 54.00',
                  size: 16,
                  fontFamily: 'semi',
                  color: AppColors.primaryDark,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: prefer_const_constructors
                TextWidget(
                  text: 'Subtotal',
                  size: 16,
                  fontFamily: 'semi',
                  color: AppColors.primaryDark,
                  textAlign: TextAlign.center,
                ),
                TextWidget(
                  text: 'SAR 59.50',
                  size: 16,
                  fontFamily: 'semi',
                  color: AppColors.primaryDark,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // ignore: prefer_const_constructors
                Get.to(CheckOutScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: TextWidget(
                text: 'Continue to Checkout',
                size: 16,
                fontFamily: 'semi',
                color: AppColors.whiteColor,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            TextWidget(
              text: 'Taxes & shipping calculated on checkout',
              size: 14,
              fontFamily: 'normal',
              color: AppColors.greyLight,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
