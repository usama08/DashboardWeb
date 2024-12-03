import '../../../../enums/dependencies.dart';

class SelecTionField extends StatefulWidget {
  final String labelText;
  final String placeholderText;
  final int initialDependents;
  final TextEditingController controller;

  // ignore: use_super_parameters
  const SelecTionField({
    Key? key,
    required this.labelText,
    required this.placeholderText,
    required this.initialDependents,
    required this.controller,
  }) : super(key: key);

  @override
  State<SelecTionField> createState() => _SelecTionFieldState();
}

class _SelecTionFieldState extends State<SelecTionField> {
  late int dependents;

  @override
  void initState() {
    super.initState();
    dependents = widget.initialDependents;
    widget.controller.text = dependents.toString();
  }

  void _updateDependentsFromText(String text) {
    final parsed = int.tryParse(text);
    if (parsed != null && parsed >= 0) {
      setState(() {
        dependents = parsed;
      });
    } else {
      widget.controller.text = dependents.toString();
    }
  }

  Color _getHintTextColor() {
    return (dependents == 0 ||
            widget.placeholderText == 'Monthly income in Saudi Riyal')
        ? AppColors.greyLight.withOpacity(0.2)
        : AppColors.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: TextWidget(
            text: widget.labelText,
            size: 14,
            fontFamily: 'semi',
            color: AppColors.greyLight.withOpacity(0.7),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.greyLight, width: 0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.placeholderText,
                    hintStyle: TextStyle(
                      color: _getHintTextColor(),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'semi',
                    fontSize: 14,
                    color: AppColors.primaryDark,
                  ),
                  onChanged: _updateDependentsFromText,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: HeroIcon(
                      HeroIcons.chevronUp,
                      color: AppColors.blackColor,
                      size: 16,
                      style: HeroIconStyle.solid,
                    ),
                    onPressed: () {
                      setState(() {
                        dependents++;
                        widget.controller.text = dependents.toString();
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: HeroIcon(
                      HeroIcons.chevronDown,
                      color: AppColors.blackColor,
                      size: 16,
                      style: HeroIconStyle.solid,
                    ),
                    onPressed: () {
                      setState(() {
                        if (dependents > 0) {
                          dependents--;
                          widget.controller.text = dependents.toString();
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
