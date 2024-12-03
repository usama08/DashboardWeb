import '../enums/dependencies.dart';

class CustomField extends StatelessWidget {
  final String hint;
  final String? labelText;
  final bool readOnly;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboard;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscure;
  final int maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  const CustomField({
    super.key,
    this.labelText,
    this.onChanged,
    this.contentPadding,
    required this.hint,
    required this.controller,
    this.validator,
    this.keyboard = TextInputType.text,
    this.inputFormatters,
    this.suffixIcon,
    this.obscure = false,
    this.readOnly = false,
    this.prefixIcon,
    this.maxLines = 1,
    this.focusNode,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      borderSide: borderColor != null && borderWidth != null
          ? BorderSide(color: borderColor!, width: borderWidth!)
          : BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      readOnly: readOnly,
      focusNode: focusNode,
      controller: controller,
      style: MyTextStyle.openSansRegular(16, AppColors.primaryDark),
      obscureText: obscure,
      obscuringCharacter: "*",
      keyboardType: keyboard,
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      validator: validator,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: MyTextStyle.openSansRegular(14, AppColors.greyLight),
        hintText: hint,
        hintStyle: MyTextStyle.openSansRegular(14, AppColors.greyLight),
        filled: true,
        fillColor: AppColors.fieldColor,
        contentPadding: contentPadding ?? const EdgeInsets.all(18),
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          maxHeight: 40,
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          maxHeight: 40,
        ),
      ),
    );
  }
}
