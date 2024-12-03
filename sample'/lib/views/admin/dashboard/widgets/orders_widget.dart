import '../../../../enums/dependencies.dart';

class PendingWidget extends StatelessWidget {
  final String title, description;
  final VoidCallback onTap;
  const PendingWidget({super.key, required this.title, required this.description, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(text: title, size: 16, fontFamily: "bold", color: AppColors.primaryDark),
                    const SizedBox(height: 8),
                    TextWidget(text: description, size: 14, fontFamily: "regular", color: AppColors.greyDark)
                  ],
                )),
                const SizedBox(width: 5),
                HeroIcon(HeroIcons.chevronRight,style: HeroIconStyle.solid,
                    color: AppColors.primaryDark,
                    size: 18)
              ],
            )


          ],
        ),
      )
    );
  }
}
