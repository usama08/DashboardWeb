
import '../../../../enums/dependencies.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: authController.formKey2,
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
                      Image.asset(AppImages.logoDark,width: MediaQuery.of(context).size.width*0.4),
                      const SizedBox(height: 80),
                      TextWidget(text: "Forget Password", size: 28, fontFamily: "bold", color: AppColors.primaryDark),
                      const SizedBox(height: 5),
                      Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                        child: TextWidget(text: "Enter the email address associated with your CharityLife account", size: 14, fontFamily: "regular",
                            color: AppColors.greyLight,textAlign: TextAlign.center),),
                      const SizedBox(height: 40),
                      CustomField(hint: 'Email address', controller: authController.forgetEmail,
                        suffixIcon:authController.forgetEmail.text.isNotEmpty?
                        GestureDetector(
                          onTap: (){
                            if(mounted){
                              setState(() {
                                authController.forgetEmail.text = "";
                              });
                            }
                          },
                          child: HeroIcon(
                              HeroIcons.xCircle,
                              style: HeroIconStyle.solid,
                              color: const Color(0xFF5E646C).withOpacity(0.4),
                              size: 25),
                        ): null,
                        validator: (value) {
                          if(value ==null || value.isEmpty){
                            return "* Please Enter Your Email";

                          }
                          else if((RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value) ==
                              false) ){
                            return "* Please Enter Valid Email";
                          }
                          return null;
                        },
                        onChanged: (val){
                          if(mounted){
                            setState(() {

                            });
                          }
                        },
                        keyboard: TextInputType.emailAddress,),
                      const SizedBox(height: 20),
                      MyFancyButton(
                          isIconButton: false,
                          fontSize: 16,
                          family: "OpenSans-SemiBold",
                          fontColor: AppColors.whiteColor,
                          text: "Send OTP",
                          tap: authController.forgetEmail.text.isNotEmpty? (){
                            if (authController.formKey2.currentState!.validate()) {
                              authController.sendOTP(context);
                            }
                          }:(){},
                          borderRadius: 100,
                          height: 50,
                          buttonColor: authController.forgetEmail.text.isNotEmpty ? AppColors.primaryColor:
                          AppColors.primaryLight,
                          hasShadow: false),
                    ],
                  ),
                ),
              ),

            ),
          )),
    );
  }
}
