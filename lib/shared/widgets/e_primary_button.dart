import 'package:flutter/material.dart';
import 'package:parking_manager/shared/themes/app_colors.dart';

class EPrimaryButton extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  final double width;
  final double borderRadius;
  final Color backgroundColor;
  final Color shadowColor;
  final Color borderColor;
  final VoidCallback onPressed;

  const EPrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.borderColor = AppColors.primary,
    this.backgroundColor = Colors.transparent,
    this.shadowColor = Colors.transparent,
    this.textStyle,
    this.width = double.infinity,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          title,
          style: textStyle ?? TextStyle(color: borderColor),
        ),
      ),
    );
  }
}
