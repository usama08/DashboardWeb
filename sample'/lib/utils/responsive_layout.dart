

import 'package:charity_life/enums/dependencies.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({super.key,
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
  });

  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width <= 1024 &&
          MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1366;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 650) {
          return mobileBody;
        } else if (constraints.maxWidth <= 1024) {
          return tabletBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
