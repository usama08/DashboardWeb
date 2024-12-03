import 'package:dashboarweb/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/menu_app_controller.dart';
import '../../responsive.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using `builder` to ensure that the context has access to the provider
    return Builder(
      builder: (context) {
        return Scaffold(
          key: context.read<MenuAppController>().scaffoldKey,
          drawer: SideMenu(),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  Expanded(
                    child: SideMenu(),
                  ),
                Expanded(
                  flex: 5,
                  child: DashboardScreen(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
