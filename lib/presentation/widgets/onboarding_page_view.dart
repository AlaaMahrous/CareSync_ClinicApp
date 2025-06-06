import 'package:clinic/core/utils/lists_managar.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class OnboardingPageView extends StatelessWidget {
  OnboardingPageView({super.key, required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: Image.asset(
            ListsManagar.onBoardingImages[index],
            fit: BoxFit.contain,
            height: 400.h,
            width: double.infinity,
            errorBuilder:
                (context, error, stackTrace) => const Icon(Icons.error),
          ),
        ),
        SizedBox(height: 35.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            ListsManagar.onBoardingText[index],
            style: TextStyleManager.onboardingText,
          ),
        ),
      ],
    );
  }
}
