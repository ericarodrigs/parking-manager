import 'package:flutter/material.dart';
import 'package:parking_manager/shared/themes/app_colors.dart';

class ESnackBar {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
