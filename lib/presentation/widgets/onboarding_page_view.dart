import 'package:clinic/core/utils/lists_managar.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnboardingPageView extends StatelessWidget {
  OnboardingPageView({super.key, required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            ListsManagar.onBoardingImages[index],
            fit: BoxFit.fill,
            height: 400,
            width: double.infinity,
            errorBuilder:
                (context, error, stackTrace) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            ListsManagar.onBoardingText[index],
            style: TextStyleManager.onboardingText,
          ),
        ),
      ],
    );
  }
}
