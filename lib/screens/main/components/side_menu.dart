import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Auth/signup.dart';
import '../../dashboard/Listing/listproduct.dart';
import '../../documents/document_screeen.dart';
import '../../notifications/notifications.dart';
import '../../profile/profile_screen.dart';
import '../../store/store_screen.dart';
import '../../task/task_screen.dart';
import '../../transactions/transaction_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  // Function to check if the user is registered/logged in
  bool isUserLoggedIn() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  // Function to navigate based on login status
  void handleNavigation(BuildContext context, Widget screen) {
    if (isUserLoggedIn()) {
      // If user is logged in, navigate to the desired screen
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    } else {
      // If user is not logged in, navigate to RegisterPromptScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPromptScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              handleNavigation(context, TransactionScreen());
            },
          ),
          DrawerListTile(
            title: "Transaction",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              handleNavigation(context, TransactionScreen());
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
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));

                // Navigate to the SignUp screen
              },
              child: const Text("Register Now"),
            ),
          ],
        ),
      ),
    );
  }
}
