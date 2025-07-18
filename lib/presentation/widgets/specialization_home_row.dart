import 'package:clinic/core/services/supabase/specializations_service.dart';
import 'package:clinic/core/utils/app_constants.dart';
import 'package:clinic/presentation/widgets/specialization_item.dart';
import 'package:clinic/presentation/widgets/specialization_item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecializationHomeRow extends StatelessWidget {
  const SpecializationHomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: SpecializationsService.instance.getSpecializations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const SpecializationItemShimmer();
              },
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No specializations found'));
        }

        final specializations = snapshot.data!;
        return SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: specializations.length,
            itemBuilder: (context, index) {
              final spec = specializations[index];
              return SpecializationItem(
                specialization: spec[AppConstants.specializationName],
                image: spec[AppConstants.specializationImage],
              );
            },
          ),
        );
      },
    );
  }
}
