import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Auth/controller/authcontroller.dart';
import '../../Auth/signup.dart';
import '../../User/MyPolicies.dart';
import '../../dashboard/Listing/listproduct.dart';
import '../../documents/document_screeen.dart';
import '../../notifications/notifications.dart';
import '../../profile/profile_screen.dart';
import '../../store/store_screen.dart';
import '../../transactions/transaction_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final AuthController authcontroller = Get.put(AuthController());

  void handleNavigation(BuildContext context, Widget screen) {
    if (authcontroller.isLoggedIn) {
      Get.to(() => screen);
    } else {
      Get.to(() => RegisterPromptScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                ),
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/myuic.png",
                  height: 60,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  DrawerListTile(
                    title: "Dashboard",
                    svgSrc: "assets/icons/menu_dashboard.svg",
                    press: () {
                      handleNavigation(context, TransactionScreen());
                    },
                  ),
                  DrawerListTile(
                    title: "My Policies",
                    svgSrc: "assets/icons/menu_tran.svg",
                    press: () {
                      handleNavigation(context, MyPolicies());
                    },
                  ),
                  DrawerListTile(
                    title: "Listing",
                    svgSrc: "assets/icons/menu_task.svg",
                    press: () {
                      handleNavigation(context, ProductListingScreen());
                    },
                  ),
                  DrawerListTile(
                    title: "Documents",
                    svgSrc: "assets/icons/menu_doc.svg",
                    press: () {
                      handleNavigation(context, DocumentScreen());
                    },
                  ),
                  DrawerListTile(
                    title: "Store",
                    svgSrc: "assets/icons/menu_store.svg",
                    press: () {
                      handleNavigation(context, StoreScreen());
                    },
                  ),
                  DrawerListTile(
                    title: "Notification",
                    svgSrc: "assets/icons/menu_notification.svg",
                    press: () {
                      handleNavigation(context, NotificationScreen());
                    },
                  ),
                  DrawerListTile(
                    title: "Profile",
                    svgSrc: "assets/icons/menu_profile.svg",
                    press: () {
                      handleNavigation(context, ProfileScreen());
                    },
                  ),
                  DrawerListTile(
                    title: "Settings",
                    svgSrc: "assets/icons/menu_setting.svg",
                    press: () {},
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

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        height: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      hoverColor: Colors.blue.withOpacity(0.3),
    );
  }
}

// Screen to prompt user to register
class RegisterPromptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Required'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You are not registered!",
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Get.to(() => SignUpScreen());
              },
              child: const Text("Register Now"),
            ),
          ],
        ),
      ),
    );
  }
}
