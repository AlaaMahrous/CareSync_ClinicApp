import 'package:clinic/core/utils/app_constants.dart';
import 'package:clinic/presentation/widgets/specialization_item.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SpecializationHomeRow extends StatelessWidget {
  SpecializationHomeRow({super.key});

  final SupabaseStreamFilterBuilder streams = Supabase.instance.client
      .from(AppConstants.specializationsTable)
      .stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: streams,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No specializations found'));
        }

        final specializations = snapshot.data!;
        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemCount: specializations.length,
            itemBuilder: (context, index) {
              final spec = specializations[index];
              return SpecializationItem(
                specialization: spec[AppConstants.specializationSpecialization],
                image: spec[AppConstants.specializationImage],
              );
            },
          ),
        );
      },
    );
  }
}
