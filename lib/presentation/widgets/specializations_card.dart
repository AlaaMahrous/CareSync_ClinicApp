import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecializationsCard extends StatelessWidget {
  const SpecializationsCard({super.key, required this.spec});

  final Map<String, dynamic> spec;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.w,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: Image.network(
            spec['image'],
            width: 50.w,
            height: 50.h,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) =>
                    Icon(Icons.image_not_supported, size: 50.r),
          ),
        ),
        title: Text(
          spec['specialization'],
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
