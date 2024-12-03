//ignore_for_file: deprecated_member_use
import '../../../../enums/dependencies.dart';

class NewPassword extends StatefulWidget {
  final String email;
  const NewPassword({super.key, required this.email});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  var authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          Get.offAll(() => const LoginScreen());
        },
        child: Obx(() => Scaffold(
              body: SafeArea(
                  bottom: false,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: authController.formKey3,
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
                              const SizedBox(height: 80),
                              TextWidget(
                                  text: "Set new password",
                                  size: 28,
                                  fontFamily: "bold",
                                  color: AppColors.primaryDark),
                              const SizedBox(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: TextWidget(
                                    text:
                                        "Enter a new and more secure password for your account",
                                    size: 14,
                                    fontFamily: "regular",
                                    color: AppColors.greyLight,
                                    textAlign: TextAlign.center),
                              ),
                              const SizedBox(height: 40),
                              CustomField(
                                hint: 'New Password',
                                controller: authController.newPass,
                                obscure: authController.pass2.value,
                                onChanged: (val) {
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    authController.togglePassword2();
                                  },
                                  child: HeroIcon(
                                      authController.pass2.value
                                          ? HeroIcons.eyeSlash
                                          : HeroIcons.eye,
                                      style: HeroIconStyle.solid,
                                      color: const Color(0xFF5E646C)
                                          .withOpacity(0.4),
                                      size: 25),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "* Please Enter New Password";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomField(
                                hint: 'Confirm Password',
                                controller: authController.confirmPass,
                                obscure: authController.pass3.value,
                                onChanged: (val) {
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    authController.togglePassword3();
                                  },
                                  child: HeroIcon(
                                      authController.pass3.value
                                          ? HeroIcons.eyeSlash
                                          : HeroIcons.eye,
                                      style: HeroIconStyle.solid,
                                      color: const Color(0xFF5E646C)
                                          .withOpacity(0.4),
                                      size: 25),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "* Please Enter Confirm Password";
                                  } else if (value.toString().trim() !=
                                      authController.newPass.text
                                          .toString()
                                          .trim()) {
                                    return "* Password Must Match";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 40),
                              MyFancyButton(
                                  isIconButton: false,
                                  fontSize: 16,
                                  family: "OpenSans-SemiBold",
                                  fontColor: AppColors.whiteColor,
                                  text: "Save",
                                  tap: authController.newPass.text.isNotEmpty &&
                                          authController
                                              .confirmPass.text.isNotEmpty
                                      ? () {
                                          if (authController
                                              .formKey3.currentState!
                                              .validate()) {
                                            authController.resetPassword(
                                                widget.email, context);
                                          }
                                        }
                                      : () {},
                                  borderRadius: 100,
                                  height: 50,
                                  buttonColor:
                                      authController.newPass.text.isNotEmpty &&
                                              authController
                                                  .confirmPass.text.isNotEmpty
                                          ? AppColors.primaryColor
                                          : AppColors.primaryLight,
                                  hasShadow: false),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            )));
  }
}
