import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  const CustomButton1({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor = Colors.white,
    this.buttonColor = ColorsManager.sAppColor,
  });
  final String text;
  final void Function() onTap;
  final Color textColor;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
