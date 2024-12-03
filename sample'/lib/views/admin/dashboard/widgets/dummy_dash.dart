import 'package:charity_life/views/admin/dashboard/screens/orders_screen.dart';
import '../../../../enums/dependencies.dart';
import 'inventory_widget.dart';
import 'orders_widget.dart';
import 'top_bar.dart';
import 'total_donation_widget.dart';

class DummyDash extends StatelessWidget {
  const DummyDash({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBar(),
        const SizedBox(height: 15),
        const TotalDonationWidget(),
        const SizedBox(height: 20),
        const InventoryWidget(),
        const SizedBox(height: 20),
        PendingWidget(title: "Manage Pending Orders",description:"You can see the details of all beneficiaries pending orders here.",
            onTap: (){
              Get.to(()=> const OrdersScreen(title: "Manage Pending Orders"));
            }),
        const SizedBox(height: 20),
        PendingWidget(title: "Pending Donations",description:"You can post all the un-posted donations from donors through here.",onTap: (){
        },),
        const SizedBox(height: 20),
        PendingWidget(title: "Pending User Approvals",description:"You can approve or reject all new users signed up on the system through here.",onTap: (){},),
        const SizedBox(height: 20),
      ],
    );
  }
}
