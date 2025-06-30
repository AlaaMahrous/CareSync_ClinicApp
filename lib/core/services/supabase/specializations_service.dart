import 'package:clinic/core/utils/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SpecializationsService {
  static SpecializationsService instance = SpecializationsService._internal();
  factory SpecializationsService() => instance;
  SpecializationsService._internal();

  Future<List<Map<String, dynamic>>> getSpecializations() async {
    final response = await Supabase.instance.client
        .from(AppConstants.specializationsTable)
        .select()
        .order('id', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }
}
