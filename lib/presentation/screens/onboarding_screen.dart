import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/lists_managar.dart';
import 'package:clinic/presentation/screens/auth/login_screen.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:clinic/presentation/widgets/onboarding_page_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static final String path = '/OnboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            SizedBox(
              height: 520,
              child: PageView.builder(
                controller: _pageController,
                itemCount: ListsManagar.onBoardingImages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: OnboardingPageView(index: index),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: ListsManagar.onBoardingImages.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: ColorsManager.mainAppColor,
                    dotColor: Colors.grey.shade400,
                  ),
                ),
                if (currentIndex != ListsManagar.onBoardingImages.length - 1)
                  CustomButton(
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Next',
                    width: 150,
                    r: 60,
                  )
                else
                  CustomButton(
                    onTap: () {
                      GoRouter.of(context).go(LoginScreen.path);
                    },
                    text: 'Get Started',
                    width: 150,
                    r: 60,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
