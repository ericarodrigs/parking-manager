import 'package:flutter/material.dart';
import 'package:parking_manager/shared/app_colors.dart';

class AppTextStyles {
  static TextStyle medium14white() => const TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  static TextStyle bold16white() => const TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );

  static TextStyle bold24black() => const TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      );
}
