// ignore: use_key_in_widget_constructors
import '../../../../enums/dependencies.dart';

// ignore: use_key_in_widget_constructors
class OrderListing extends StatefulWidget {
  @override
  State<OrderListing> createState() => _OrderListingState();
}

class _OrderListingState extends State<OrderListing> {
  final List<String> orders = [
    "Order #1",
    "Order #2",
    "Order #3",
    "Order #4",
    "Order #5",
    "Order #6",
    "Order #7",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Order no.',
                        size: 14,
                        fontFamily: 'bold',
                        color: AppColors.primaryDark,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      TextWidget(
                        text: '325147',
                        size: 12,
                        fontFamily: 'regular',
                        color: AppColors.greyLight,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  // const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Placed on',
                        size: 14,
                        fontFamily: 'bold',
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
                        text: 'SAR 54.00',
                        size: 12,
                        fontFamily: 'bold',
                        color: AppColors.primaryDark,
                        textAlign: TextAlign.start,
                      )
                    ],
                  )
                ],
              ),
              // ignore: prefer_const_constructors
              SizedBox(height: 20),

              // View Order Button with hover and tap effect
              InkWell(
                onTap: () {
                  // Handle the tap event
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.primaryDark, width: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: 'View details',
                          size: 12,
                          fontFamily: 'bold',
                          color: AppColors.primaryColor,
                          textAlign: TextAlign.center,
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(width: 4),
                        HeroIcon(
                          HeroIcons.shoppingCart,
                          color: AppColors.primaryColor,
                          size: 20,
                          style: HeroIconStyle.solid,
                        ),
                      ],
                    )),
                onHover: (isHovered) {
                  setState(() {
                    isHovered ? AppColors.primaryColor : AppColors.primaryLight;
                  });
                },
                onTapDown: (_) {
                  setState(() {});
                },
                onTapUp: (_) {
                  setState(() {});
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
