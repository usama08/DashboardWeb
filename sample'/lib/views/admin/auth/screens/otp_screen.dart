
import '../../../../enums/dependencies.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var authController = Get.put(AuthController());
  bool isLoading = false;
  int start = 120;
  bool verifyText = false;
  bool wait = false;

  Timer? _timer;
  void startTimer() {
    const onSec = Duration(seconds: 1);
    _timer = Timer.periodic(onSec, (timer) {
      if (start == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            _timer!.cancel();
            wait = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            start--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
   // _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {

    const focusedBorderColor = Color(0xFFE1E3E7);
    const fillColor = Color(0xFFE1E3E7);
    const borderColor = Color(0xFFEDEFF3);

    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: MyTextStyle.openSansBold(20, AppColors.primaryDark),
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: AnimationLimiter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),

                  children: [
                    const SizedBox(height:20),
                    TextWidget(text: "6-digit code", size: 28, fontFamily: "bold", color: AppColors.primaryDark),
                    const SizedBox(height: 5),
                    Padding(padding: const EdgeInsets.only(right: 20),
                      child: TextWidget(text: "Please enter the code we’ve sent to your email address", size: 14, fontFamily: "regular",
                          color: AppColors.greyLight,textAlign: TextAlign.start),),
                    const SizedBox(height:40),
                    Pinput(
                      length: 6,
                      errorTextStyle: MyTextStyle.openSansSemiBold(12, Colors.red),
                      controller: authController.otpController,
                      defaultPinTheme: defaultPinTheme,
                      closeKeyboardWhenCompleted: true,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      validator: (pin) {
                        if (pin!.isEmpty) {
                          return "Please enter all otp code";
                        }
                        else if (pin.length < 6) {
                          return "You should enter all otp code";
                        } else {
                          return null;
                        }
                      },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                      },
                      onChanged: (value) {
                        if(mounted){
                          setState(() {

                          });
                        }
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        TextWidget(text: "Didn’t get the code?", size: 12, fontFamily: "regular",
                            color: AppColors.greyLight,textAlign: TextAlign.start),
                        const SizedBox(width: 5),
                        TextWidget(text: "Resend in ${formatedTime(time: start)}", size: 14, fontFamily: "regular",
                            color: AppColors.primaryColor,textAlign: TextAlign.start)
                      ],
                    ),
                    const SizedBox(height: 50),
                    MyFancyButton(
                        isIconButton: false,
                        fontSize: 16,
                        family: "OpenSans-SemiBold",
                        fontColor: AppColors.whiteColor,
                        text: "Verify",
                        tap: authController.otpController.text.isNotEmpty? (){
                          if (authController.otpController.text.length==6) {
                            authController.verifyOTP(context);
                          }
                          else{
                            BotToast.showSimpleNotification(title: "Enter Complete OTP Code",titleStyle: MyTextStyle.openSansRegular(14,AppColors.whiteColor),
                                borderRadius: 12.0,backgroundColor: Colors.red);
                          }
                        }: (){},
                        borderRadius: 100,
                        height: 50,
                        buttonColor: authController.otpController.text.isNotEmpty ? AppColors.primaryColor:
                        AppColors.primaryLight,
                        hasShadow: false),
                  ],
                ),
              ),
            )
          )),
    );
  }

  formatedTime({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

}
