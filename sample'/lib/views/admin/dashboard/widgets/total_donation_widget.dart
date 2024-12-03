import 'package:charity_life/views/admin/dashboard/widgets/allocate_users.dart';

import '../../../../enums/dependencies.dart';

class TotalDonationWidget extends StatelessWidget {
  const TotalDonationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var dashController = Get.put(DashController());
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: TextWidget(text: "Total Donations Amount", size: 14, fontFamily: "regular", color: AppColors.primaryDark)),
              const SizedBox(width: 20),
              MyFancyButton(isIconButton: false, fontSize: 14, text: "+ Allocate Donations",
                  family: "OpenSans-SemiBold",
                  fontColor: AppColors.whiteColor,
                  borderRadius: 8,
                  tap: (){
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => const AllocateUsers(),
                    );
                  },
                  height: 40,
                  buttonColor: AppColors.primaryColor, hasShadow: false,
              width: 180,)
            ],
          ),
          const SizedBox(height: 10),
          TextWidget(text: "SAR ${dashController.isLoading.value?"0.0":dashController.dashboardModel.data.totalDonations.toString()} ", size: 20, fontFamily: "bold", color: AppColors.primaryDark),
          Row(
            children: [
              HeroIcon(HeroIcons.chevronDoubleUp,color: AppColors.primaryColor,style: HeroIconStyle.solid,size: 18),
              TextWidget(text: " ${dashController.isLoading.value?"0.0":dashController.dashboardModel.data.growthRateDonation}% ", size: 14, fontFamily: "regular", color: AppColors.primaryColor),
              TextWidget(text: "than last month", size: 14, fontFamily: "regular", color: AppColors.greyLight)
            ],
          ),

        ],
      ),
    );
  }
}
