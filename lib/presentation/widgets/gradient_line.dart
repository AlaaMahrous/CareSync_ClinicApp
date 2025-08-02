import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class GradientLine extends StatelessWidget {
  const GradientLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 20,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.mainAppColor,
            Color.fromARGB(255, 87, 217, 231),
            Colors.white,
          ],
        ),
      ),
    );
  }
}
