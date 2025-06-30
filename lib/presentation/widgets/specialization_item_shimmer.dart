import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SpecializationItemShimmer extends StatelessWidget {
  const SpecializationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Container(color: Colors.white, width: 60.w, height: 60.h),
            ),
            SizedBox(height: 8.h),
            Container(width: 70.w, height: 12.h, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
