import '../../../../enums/dependencies.dart';

// ignore: use_key_in_widget_constructors
class MyOrderCard extends StatelessWidget {
  final List<String> orders = [
    "Order #1",
    "Order #2",
    "Order #3",
    "Order #4",
    "Order #5",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.greyLight.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Order number',
                        size: 14,
                        fontFamily: 'bold',
                        color: AppColors.primaryDark,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      TextWidget(
                        text: 'Placed on',
                        size: 12,
                        fontFamily: 'regular',
                        color: AppColors.greyLight,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: '325147',
                        size: 14,
                        fontFamily: 'regular',
                        color: AppColors.primaryDark,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      TextWidget(
                        text: '11 Nov 2024',
                        size: 12,
                        fontFamily: 'regular',
                        color: AppColors.greyLight,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Delivered',
                        size: 12,
                        fontFamily: 'bold',
                        color: AppColors.primaryLight,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      TextWidget(
                        text: '',
                        size: 14,
                        fontFamily: 'bold',
                        color: AppColors.greyLight,
                        textAlign: TextAlign.start,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.addtocart,
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 75,
                            height: 80,
                            child: Image.asset(
                              AppImages.cartproduct,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Koko Krunch',
                        size: 14,
                        fontFamily: 'bold',
                        color: AppColors.primaryDark,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      TextWidget(
                        text: '300g Pack',
                        size: 12,
                        fontFamily: 'regular',
                        color: AppColors.greyLight,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Total',
                        size: 12,
                        fontFamily: 'semi',
                        color: AppColors.greyLight,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      TextWidget(
                        text: 'SAR 54.00',
                        size: 14,
                        fontFamily: 'bold',
                        color: AppColors.greyLight,
                        textAlign: TextAlign.start,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
