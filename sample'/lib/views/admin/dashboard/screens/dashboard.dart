//ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:charity_life/views/admin/dashboard/screens/donations_screen.dart';
import 'package:charity_life/views/admin/dashboard/screens/orders_screen.dart';
import 'package:charity_life/views/admin/dashboard/screens/pending_users.dart';
import 'package:charity_life/views/admin/dashboard/widgets/dummy_dash.dart';
import '../../../../enums/dependencies.dart';
import '../widgets/inventory_widget.dart';
import '../widgets/orders_widget.dart';
import '../widgets/top_bar.dart';
import '../widgets/total_donation_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var dashController = Get.put(DashController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dashController.getDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return DialogBox(
                type: "Alert",
                onTap: () {
                  exit(0);
                },
                heading: 'Exit',
                body: "Do you really want to exit application",
              );
            },
          );
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          body: SafeArea(
              bottom: false,
              child: Obx(() => RefreshIndicator(
                  color: AppColors.primaryColor,
                  key: dashController.refreshIndicatorKey,
                  onRefresh: dashController.refreshData,
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: dashController.isLoading.value
                          ? Shimmer(
                              linearGradient: AppColors.shimmerGradient,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ShimmerLoading(
                                        isLoading:
                                            dashController.isLoading.value,
                                        child: const DummyDash());
                                  }))
                          : AnimationLimiter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    AnimationConfiguration.toStaggeredList(
                                  duration: const Duration(milliseconds: 375),
                                  childAnimationBuilder: (widget) =>
                                      SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: widget,
                                    ),
                                  ),
                                  children: [
                                    const TopBar(),
                                    const SizedBox(height: 15),
                                    const TotalDonationWidget(),
                                    const SizedBox(height: 20),
                                    const InventoryWidget(),
                                    const SizedBox(height: 20),
                                    PendingWidget(
                                        title: "Manage Pending Orders",
                                        description:
                                            "You can see the details of all beneficiaries pending orders here.",
                                        onTap: () {
                                          dashController.resetOrders();
                                          Get.to(() => const OrdersScreen(
                                              title: "Manage Pending Orders"));
                                        }),
                                    const SizedBox(height: 20),
                                    PendingWidget(
                                      title: "Pending Donations",
                                      description:
                                          "You can post all the un-posted donations from donors through here.",
                                      onTap: () {
                                        dashController.resetDonations();
                                        Get.to(() => const DonationsScreen(
                                            title: "Donations"));
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    PendingWidget(
                                      title: "Pending User Approvals",
                                      description:
                                          "You can approve or reject all new users signed up on the system through here.",
                                      onTap: () {
                                        Get.to(() => const PendingUsers());
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ))))),
        ));
  }
}
