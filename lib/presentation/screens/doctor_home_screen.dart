import 'package:clinic/presentation/widgets/doctors_list_view.dart';
import 'package:clinic/presentation/widgets/specialization_home_row.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});
  static final String path = '/DoctorHomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 22),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        'https://sesjzerlawpywdufplrw.supabase.co/storage/v1/object/public/images/profile/b5408107-0a2e-4634-a15f-76135cdb4487',
                        height: 48,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hi, Alaa Mahrous',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Wish you good today!',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 72, 71, 71),
                          ),
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    const Icon(
                      HugeIcons.strokeRoundedSearch01,
                      color: Color.fromARGB(255, 157, 156, 156),
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      HugeIcons.strokeRoundedNotification03,
                      color: Color.fromARGB(255, 157, 156, 156),
                    ),
                  ],
                ),
              ),
              const Divider(height: 30, thickness: 0.09, color: Colors.grey),
              SpecializationHomeRow(),
              Expanded(child: const DoctorsListView()),
            ],
          ),
        ),
      ),
    );
  }
}
