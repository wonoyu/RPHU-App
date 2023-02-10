import 'package:flutter/material.dart';
import 'package:rphu_app/src/core/constants/colors.dart';

class CirclePageViewIndicator extends StatelessWidget {
  const CirclePageViewIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: 8,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.mainGreen,
      ),
    );
  }
}

class RoundedRectangePageViewIndicator extends StatelessWidget {
  const RoundedRectangePageViewIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: 25,
      decoration: BoxDecoration(
        color: AppColors.mainGreen,
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}
