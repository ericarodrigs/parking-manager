import 'package:flutter/material.dart';

class ETextFormField extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color borderColor;

  const ETextFormField({
    super.key,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.controller,
    this.onChanged,
    this.validator,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // style: AppTextStyles.regular16(context).copyWith(
      //   color: AppColors.grayText,
      // ),
      controller: controller,
      keyboardType: inputType,
      textInputAction: inputAction,
      cursorColor: Colors.deepPurple,
      cursorHeight: 28,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        hintText: hintText,
        // hintStyle: AppTextStyles.regular16(context).copyWith(
        //   color: AppColors.grayText,
        // ),
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
    borderSide: const BorderSide(color: Colors.grey));
