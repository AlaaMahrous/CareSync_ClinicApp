import 'package:clinic/presentation/widgets/customed_app_bar.dart';
import 'package:clinic/presentation/widgets/doctor_image_card.dart';
import 'package:clinic/presentation/widgets/doctors_list_view.dart';
import 'package:clinic/presentation/widgets/specialization_home_row.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});
  static final String path = '/DoctorHomeScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomedAppBar(),
              Divider(height: 30, thickness: 0.09, color: Colors.grey),
              DoctorImageCard(),
              SizedBox(height: 10),
              Text(
                'Doctor Speciality',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              SpecializationHomeRow(),
              Text(
                'Popular Doctors',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              Expanded(child: DoctorsListView()),
            ],
          ),
        ),
      ),
    );
  }
}
