import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.height = 48,
    this.width = double.infinity,
    this.r = 10,
  });
  final String text;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double r;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r.r),
          color: ColorsManager.mainAppColor,
        ),
        width: width.w,
        height: height.h,
        child: Center(
          child: Text(
            text,
            style: TextStyleManager.loginInfo.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
