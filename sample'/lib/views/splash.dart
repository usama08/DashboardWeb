import 'package:charity_life/enums/dependencies.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  void checkLoggedIn() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAll(() => const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(AppImages.appLogo,
            width: MediaQuery.of(context).size.width * 0.75),
      ),
    );
  }
}
