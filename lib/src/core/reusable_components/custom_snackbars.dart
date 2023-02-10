import 'package:flutter/material.dart';
import 'package:rphu_app/src/core/constants/colors.dart';

class CustomSnackbars {
  static showSuccessSnackbar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.mainGreen,
          behavior: SnackBarBehavior.floating,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          content: Text(message),
          action: SnackBarAction(
            label: 'TUTUP',
            textColor: AppColors.white,
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
          ),
        ),
      );

  static showErrorSnackbar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.red,
          behavior: SnackBarBehavior.floating,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          content: Text(message),
          action: SnackBarAction(
            label: 'TUTUP',
            textColor: AppColors.white,
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
          ),
        ),
      );
}
