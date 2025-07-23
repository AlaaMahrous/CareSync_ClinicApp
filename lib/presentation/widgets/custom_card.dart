import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.text,
    this.color = ColorsManager.sAppColor,
  });
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      constraints: const BoxConstraints(maxWidth: 110),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
