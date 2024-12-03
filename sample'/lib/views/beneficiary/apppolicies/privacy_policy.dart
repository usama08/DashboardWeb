import '../../../../enums/dependencies.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
            color: AppColors.blackColor,
            size: 24,
            style: HeroIconStyle.solid,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: "Privacy Policy",
                  size: 28,
                  fontFamily: "bold",
                  color: AppColors.primaryDark,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 20),
                TextWidget(
                  text: "Your data is yours",
                  size: 20,
                  fontFamily: "bold",
                  color: AppColors.primaryDark,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10),
                TextWidget(
                  text:
                      "Enter a new and more secure password for your account lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.",
                  size: 14,
                  fontFamily: "regular",
                  color: AppColors.greyLight,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                TextWidget(
                  text: "How we use your personal data",
                  size: 20,
                  fontFamily: "bold",
                  color: AppColors.primaryDark,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10),
                TextWidget(
                  text:
                      "Enter a new and more secure password for your account lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.",
                  size: 14,
                  fontFamily: "regular",
                  color: AppColors.greyLight,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                TextWidget(
                  text:
                      "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  size: 14,
                  fontFamily: "regular",
                  color: AppColors.greyLight,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                TextWidget(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud. Enter a new and more secure password for your account lorem ipsum.",
                  size: 14,
                  fontFamily: "regular",
                  color: AppColors.greyLight,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryColor,
                      value: _isAccepted,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isAccepted = newValue ?? false;
                        });
                      },
                      side: BorderSide(
                        color: AppColors.primaryDark,
                      ),
                    ),
                    Text('I have read and accept all policies',
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
                  text: "I accept",
                  tap: _isAccepted ? () {} : () {},
                  borderRadius: 100,
                  height: 50,
                  buttonColor: _isAccepted
                      ? AppColors.primaryColor
                      : AppColors.primaryLight,
                  hasShadow: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
