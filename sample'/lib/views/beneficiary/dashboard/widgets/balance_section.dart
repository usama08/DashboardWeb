import '../../../../enums/dependencies.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    var beneficiaryController = Get.put(BeneficiaryController());

    return Container(
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeroIcon(
                            HeroIcons.bars3BottomLeft,
                            color: AppColors.whiteColor,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          TextWidget(
                            text:
                                "Welcome, \n${authController.loginData.fullName}!",
                            size: 16,
                            fontFamily: "regular",
                            color: AppColors.whiteColor.withOpacity(0.9),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          HeroIcon(HeroIcons.bell,
                              style: HeroIconStyle.solid,
                              color: AppColors.whiteColor,
                              size: 30),
                          const SizedBox(width: 10),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == "logout") {
                                Get.offAll(() => const LoginScreen());
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            offset: const Offset(0, 30),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(AppImages.person),
                            ),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  value: 'logout',
                                  child: Row(
                                    children: [
                                      HeroIcon(
                                          HeroIcons.arrowRightStartOnRectangle,
                                          style: HeroIconStyle.solid,
                                          color: AppColors.primaryColor,
                                          size: 30),
                                      const SizedBox(width: 10),
                                      TextWidget(
                                          text: "Log Out",
                                          size: 14,
                                          fontFamily: "medium",
                                          color: AppColors.primaryDark),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (authController.loginData.groupId == 3)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 120),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: "Account Balance",
                          size: 14,
                          fontFamily: "regular",
                          color: AppColors.whiteColor,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 10),
                        HeroIcon(HeroIcons.exclamationCircle,
                            color: AppColors.whiteColor, size: 22),
                      ],
                    ),
                    Obx(() {
                      return TextWidget(
                        text:
                            "${beneficiaryController.productListing.value.accountBalance}",
                        size: 24,
                        fontFamily: "bold",
                        color: AppColors.whiteColor,
                        textAlign: TextAlign.center,
                      );
                    }),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
