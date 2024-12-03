import 'package:intl/intl.dart';
import '../../../../enums/dependencies.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: DateFormat("EEE, dd MMMM").format(DateTime.now()), size: 14, fontFamily: "regular",
                color: AppColors.greyLight,textAlign: TextAlign.center),
            TextWidget(text: "Dashboard", size: 28, fontFamily: "bold", color: AppColors.primaryDark)
          ],
        ),
        Row(
          children: [
            HeroIcon(HeroIcons.bell,style: HeroIconStyle.solid,color: AppColors.primaryColor,size: 30),
            const SizedBox(width: 10),
            PopupMenuButton<String>(
              onSelected: (value) {
                if(value=="logout"){
                  Get.offAll(()=> const LoginScreen());
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
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
                        HeroIcon(HeroIcons.arrowRightStartOnRectangle,style: HeroIconStyle.solid,color: AppColors.primaryColor,size: 30),
                        const SizedBox(width: 10),
                        TextWidget(text: "Log Out", size: 14, fontFamily: "medium", color: AppColors.primaryDark)

                      ],
                    ),
                  ),
                ];
              },
            ),

          ],
        ),

      ],
    );
  }
}
