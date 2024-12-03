// ignore_for_file: prefer_const_constructors

import '../../../../enums/dependencies.dart';
import '../widgets/all_order.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
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
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
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
          text: 'My Orders',
          size: 20,
          fontFamily: 'bold',
          color: Colors.black,
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: OrderListing(),
          ),
        ],
      ),
    );
  }
}
