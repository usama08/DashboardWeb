// ignore_for_file: library_private_types_in_public_api

import '../../../../enums/dependencies.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  var beneficiaryController = Get.put(BeneficiaryController());

  bool _isExpanded = false;
  Set<int> displayedCategoryIds = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categories = beneficiaryController.productListing.value.data;
      if (categories.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      List<dynamic> uniqueCategories = [];
      for (var category in categories) {
        if (!displayedCategoryIds.contains(category.categoryId)) {
          uniqueCategories.add(category);
          displayedCategoryIds.add(category.categoryId);
        }
      }

      int categoryCountToShow = uniqueCategories.length > 8
          ? uniqueCategories.length
          : uniqueCategories.length;

      return Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 25),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.72,
            ),
            itemCount:
                _isExpanded ? uniqueCategories.length : categoryCountToShow,
            itemBuilder: (context, index) {
              final category = uniqueCategories[index];

              return GestureDetector(
                onTap: () {
                  beneficiaryController
                      .filterProductsByCategory(category.categoryId);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEDEFF3),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: HeroIcon(
                        HeroIcons.star,
                        color: AppColors.primaryColor,
                        style: HeroIconStyle.solid,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Show category name
                    TextWidget(
                      text: category.categoryName,
                      size: 12,
                      fontFamily: "semi",
                      color: AppColors.primaryDark,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              );
            },
          ),
          // Show 'Show More' or 'Show Less' button
          if (uniqueCategories.length > 8)
            TextButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? 'Show Less' : 'Show More',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontFamily: "semi",
                ),
              ),
            ),
          GestureDetector(
            onTap: () {
              // Reset the selected category and fetch all products
              beneficiaryController.selectedCategory.value = 0;
              beneficiaryController.getProductListing();
            },
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryDark, width: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: 'Clear Filter',
                      size: 12,
                      fontFamily: 'bold',
                      color: AppColors.primaryColor,
                      textAlign: TextAlign.center,
                    ),
                    // ignore: prefer_const_constructors
                  ],
                )),
          ),
        ],
      );
    });
  }
}
