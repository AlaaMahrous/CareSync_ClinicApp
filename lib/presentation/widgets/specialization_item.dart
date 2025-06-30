import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecializationItem extends StatelessWidget {
  const SpecializationItem({
    super.key,
    required this.image,
    required this.specialization,
  });

  final String image;
  final String specialization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              image,
              width: 55.w,
              height: 55.h,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported, size: 60.r),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            specialization,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13.5.r,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
