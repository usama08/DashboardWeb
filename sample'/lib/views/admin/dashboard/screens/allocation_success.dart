//ignore_for_file: deprecated_member_use
import '../../../../enums/dependencies.dart';

class AllocationSuccess extends StatelessWidget {
  const AllocationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          Get.offAll(()=> const Dashboard());
        },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Get.offAll(()=> const Dashboard());
                      },
                      child: HeroIcon(HeroIcons.xCircle,color: AppColors.whiteColor,style: HeroIconStyle.solid,size: 30),
                    )
                ),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeroIcon(HeroIcons.checkBadge,color: AppColors.whiteColor,style: HeroIconStyle.solid,size: 180),
                    const SizedBox(height: 10),
                    TextWidget(text: "Donations successfully allocated to all beneficiaries evenly!", size: 16, fontFamily: "regular", color: AppColors.whiteColor,
                        textAlign: TextAlign.center)
                  ],
                )),
                const SizedBox(height: 30),
                MyFancyButton(
                  isIconButton: false,
                  fontSize: 16,
                  text: 'Done',
                  tap:(){
                    Get.offAll(()=> const Dashboard());
                  },
                  buttonColor: AppColors.whiteColor,
                  hasShadow: true,
                  borderRadius: 99,
                  family: 'OpenSans-Bold',
                  fontColor: AppColors.primaryColor,
                  blurRadius: 24,
                  offset: const Offset(1, 2),
                  shadowColor: AppColors.primaryColor.withOpacity(0.24),
                ),
                const SizedBox(height: 30),
              ],
            )),
      )
    );
  }
}
