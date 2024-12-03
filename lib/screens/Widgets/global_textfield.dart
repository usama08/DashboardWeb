import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isReadOnly;
  final GestureTapCallback? onTap;

  CustomTextField({
    required this.controller,
    required this.label,
    this.isReadOnly = false,
    this.onTap,
    int? maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: isReadOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
