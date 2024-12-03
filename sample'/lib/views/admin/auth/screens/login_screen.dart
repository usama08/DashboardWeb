import '../../../../enums/dependencies.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: authController.formKey,
                  child: AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(AppImages.logoDark,
                              width: MediaQuery.of(context).size.width * 0.4),
                          const SizedBox(height: 80),
                          TextWidget(
                              text: "titleLogin".tr,
                              size: 28,
                              fontFamily: "bold",
                              color: AppColors.primaryDark),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextWidget(
                                text: "descLogin".tr,
                                size: 14,
                                fontFamily: "regular",
                                color: AppColors.greyLight,
                                textAlign: TextAlign.center),
                          ),
                          const SizedBox(height: 40),
                          CustomField(
                            hint: 'email'.tr,
                            controller: authController.emailController,
                            suffixIcon: authController
                                    .emailController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      if (mounted) {
                                        setState(() {
                                          authController.emailController.text =
                                              "";
                                        });
                                      }
                                    },
                                    child: HeroIcon(HeroIcons.xCircle,
                                        style: HeroIconStyle.solid,
                                        color: const Color(0xFF5E646C)
                                            .withOpacity(0.4),
                                        size: 25),
                                  )
                                : null,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "* Please Enter Your Email";
                              } else if ((RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value) ==
                                  false)) {
                                return "* Please Enter Valid Email";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            keyboard: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          CustomField(
                            hint: 'password'.tr,
                            controller: authController.passController,
                            obscure: authController.pass.value,
                            onChanged: (val) {
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                authController.togglePassword();
                              },
                              child: HeroIcon(
                                  authController.pass.value
                                      ? HeroIcons.eyeSlash
                                      : HeroIcons.eye,
                                  style: HeroIconStyle.solid,
                                  color:
                                      const Color(0xFF5E646C).withOpacity(0.4),
                                  size: 25),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "* Please Enter Your Password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => const ForgetPassword());
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextWidget(
                                    text: "forgot".tr,
                                    size: 14,
                                    fontFamily: "regular",
                                    color: AppColors.primaryColor),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                activeColor: AppColors.primaryColor,
                                value: authController.rememberMe.value,
                                onChanged: authController.handleRememberMe,
                                side: BorderSide(
                                  color: AppColors.primaryDark,
                                ),
                              ),
                              Text('rememberMe'.tr,
                                  style: MyTextStyle.openSansRegular(
                                      14, AppColors.primaryDark)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          MyFancyButton(
                              isIconButton: false,
                              fontSize: 16,
                              family: "OpenSans-SemiBold",
                              fontColor: AppColors.whiteColor,
                              text: "Login",
                              tap: authController
                                          .emailController.text.isNotEmpty &&
                                      authController
                                          .passController.text.isNotEmpty
                                  ? () {
                                      if (authController.formKey.currentState!
                                          .validate()) {
                                        authController.userLogin(context);
                                      }
                                    }
                                  : () {},
                              borderRadius: 100,
                              height: 50,
                              buttonColor: authController
                                          .emailController.text.isNotEmpty &&
                                      authController
                                          .passController.text.isNotEmpty
                                  ? AppColors.primaryColor
                                  : AppColors.primaryLight,
                              hasShadow: false),
                          OutlinedButton(
                              onPressed: () {
                                Get.updateLocale(const Locale('en', 'EN'));
                              },
                              child: const Text('English')),
                          OutlinedButton(
                              onPressed: () {
                                Get.updateLocale(const Locale('ar', 'AR'));
                              },
                              child: const Text('Arabic')),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ));
  }
}
