// ignore_for_file: file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../enums/dependencies.dart';

class CoustomDropdown extends StatelessWidget {
  final List<String> countries;
  final String? selectedCountry;
  final String? hint;
  final Function(String?) onChanged;
  final bool showBorder; // New parameter to toggle border

  const CoustomDropdown({
    super.key,
    required this.countries,
    required this.selectedCountry,
    required this.hint,
    required this.onChanged,
    this.showBorder = true, // Default to true if not specified
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        height: 58,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: showBorder // Conditionally show the border
              ? Border.all(
                  color: AppColors.primaryDark.withOpacity(0.5),
                  width: 0.5,
                )
              : Border.all(color: Colors.transparent), // No border if false
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            value: selectedCountry,
            items: countries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    entry,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryDark.withOpacity(0.6),
                    ),
                  ),
                ),
              );
            }).toList(),
            isExpanded: true,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextWidget(
                text: hint ?? '',
                size: 14,
                fontFamily: 'regular',
                color: AppColors.greyLight,
              ),
            ),
            onChanged: onChanged,
            style: MyTextStyle.openSansRegular(
              14,
              AppColors.primaryDark.withOpacity(0.6),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.9,
              offset: const Offset(-12, -20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: showBorder // Conditionally show the border in dropdown
                    ? Border.all(
                        color: AppColors.primaryDark.withOpacity(0.5),
                        width: 0.5,
                      )
                    : Border.all(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
