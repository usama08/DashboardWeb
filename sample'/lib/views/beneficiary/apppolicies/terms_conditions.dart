import '../../../../enums/dependencies.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
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
                  text: "Terms & Conditions",
                  size: 28,
                  fontFamily: "bold",
                  color: AppColors.primaryDark,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 20),
                TextWidget(
                  text: "Customer agreement",
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
                  text: "Terms of use",
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
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      HeroIcon(
                        HeroIcons.arrowDownTray,
                        color: AppColors.primaryColor,
                        size: 20,
                        style: HeroIconStyle.solid,
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(width: 5),
                      TextWidget(
                        text: "Download as PDF",
                        size: 14,
                        fontFamily: "semi",
                        color: AppColors.primaryColor,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MyFancyButton(
                  isIconButton: false,
                  fontSize: 16,
                  family: "OpenSans-SemiBold",
                  fontColor: AppColors.whiteColor,
                  text: "I agree",
                  tap: () {},
                  borderRadius: 100,
                  height: 50,
                  buttonColor: AppColors.primaryColor,
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
