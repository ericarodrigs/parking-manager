import 'package:flutter/material.dart';
import 'package:parking_manager/shared/app_colors.dart';
import 'package:parking_manager/shared/app_text_styles.dart';

class ETextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color borderColor;
  final bool enabled;

  const ETextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.controller,
    this.onChanged,
    this.validator,
    this.borderColor = AppColors.primary,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: inputType,
      textInputAction: inputAction,
      enabled: enabled,
      cursorColor: AppColors.primary,
      cursorHeight: 28,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        labelText: labelText,
        hintText: hintText,
        errorStyle: AppTextStyles.bold16red(),
        border: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: AppColors.primary));
