import '../../../../enums/dependencies.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({super.key});

  @override
  Widget build(BuildContext context) {
    var beneficiaryController = Get.put(BeneficiaryController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('message'.tr),
        TextWidget(
            text: 'message'.tr,
            size: 12,
            fontFamily: "regular",
            color: AppColors.primaryDark),
        const SizedBox(height: 5),
        Row(
          children: [
            HeroIcon(HeroIcons.mapPin,
                style: HeroIconStyle.solid,
                color: AppColors.primaryDark,
                size: 16),
            const SizedBox(width: 5),
            TextWidget(
                text: "Tahliah street, Riyadh, KSA",
                size: 16,
                fontFamily: "bold",
                color: AppColors.primaryDark,
                textAlign: TextAlign.start),
            const SizedBox(width: 5),
            HeroIcon(HeroIcons.chevronDown,
                style: HeroIconStyle.solid,
                color: AppColors.primaryDark,
                size: 16),
          ],
        ),
        const SizedBox(height: 15),
        CustomField(
          hint: 'Search products',
          controller: beneficiaryController.search,
          prefixIcon: HeroIcon(HeroIcons.magnifyingGlass,
              style: HeroIconStyle.solid, color: AppColors.greyDark, size: 20),
          onChanged: (val) {},
        ),
      ],
    );
  }
}
