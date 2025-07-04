import 'dart:developer';

import 'package:clinic/core/models/doctor_profile_model.dart';
import 'package:clinic/core/services/supabase/doctor_service.dart';
import 'package:clinic/presentation/widgets/doctor_profile_screen_body.dart';
import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DoctorProfileModel?>(
      future: DoctorService().getDoctorProfile(1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          log('Something went wrong ${snapshot.error}');
          return Scaffold(
            body: Center(child: Text('Something went wrong ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(body: Center(child: Text('Doctor not found')));
        }
        final doctor = snapshot.data!;
        return DoctorProfileScreenBody(doctorModel: doctor);
      },
    );
  }
}
