import '../../../../enums/dependencies.dart';
import '../controller/change_passcontroller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var changepassController = Get.put(ChangepassController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: changepassController.formKey,
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
                          const SizedBox(height: 80),
                          TextWidget(
                              text: "Change password",
                              size: 28,
                              fontFamily: "bold",
                              color: AppColors.primaryDark),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextWidget(
                                text:
                                    "Enter the email address associated with your CharityLife account",
                                size: 14,
                                fontFamily: "regular",
                                color: AppColors.greyLight,
                                textAlign: TextAlign.center),
                          ),
                          const SizedBox(height: 40),
                          CustomField(
                            hint: 'Password',
                            controller: changepassController.oldpassController,
                            obscure: changepassController.pass.value,
                            onChanged: (val) {
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                changepassController.togglePassword();
                              },
                              child: HeroIcon(
                                  changepassController.pass.value
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
                          CustomField(
                            hint: 'New Password',
                            controller: changepassController.newpassController,
                            obscure: changepassController.pass2.value,
                            onChanged: (val) {
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                changepassController.togglePassword2();
                              },
                              child: HeroIcon(
                                  changepassController.pass2.value
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
                          CustomField(
                            hint: 'Confirm Password',
                            controller:
                                changepassController.newConfirmpassController,
                            obscure: changepassController.pass3.value,
                            onChanged: (val) {
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                changepassController.togglePassword3();
                              },
                              child: HeroIcon(
                                  changepassController.pass.value
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
                              if (value !=
                                  changepassController.newpassController.text) {
                                return "* Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 20),
                          MyFancyButton(
                              isIconButton: false,
                              fontSize: 16,
                              family: "OpenSans-SemiBold",
                              fontColor: AppColors.whiteColor,
                              text: "Save new password",
                              tap: () {},
                              borderRadius: 100,
                              height: 50,
                              buttonColor: changepassController
                                          .oldpassController.text.isNotEmpty &&
                                      changepassController
                                          .newpassController.text.isNotEmpty &&
                                      changepassController
                                          .newConfirmpassController
                                          .text
                                          .isNotEmpty
                                  ? AppColors.primaryColor
                                  : AppColors.primaryLight,
                              hasShadow: false),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ));
  }
}
