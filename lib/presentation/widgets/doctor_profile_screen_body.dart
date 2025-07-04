import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/auth/sup_auth_service.dart';
import 'package:clinic/presentation/widgets/build_info_row.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hugeicons/hugeicons.dart';

class DoctorProfileScreenBody extends StatelessWidget {
  const DoctorProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    color: ColorsManager.mainAppColor,
                  ),
                  const SizedBox(height: 55),
                  const Text(
                    'Alaa Mahrous',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  RatingBarIndicator(
                    rating: 4,
                    itemCount: 5,
                    itemSize: 18,
                    direction: Axis.horizontal,
                    itemBuilder:
                        (context, _) => const Icon(
                          Icons.star,
                          color: ColorsManager.mainAppColor,
                        ),
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        BuildInfoRow(
                          icon: Icons.info_outline,
                          label: 'Bio',
                          value:
                              'Experienced skin doctor with a passion for healthy skin.',
                        ),
                        BuildInfoRow(
                          icon: HugeIcons.strokeRoundedDoctor01,
                          label: 'Specialization ',
                          value: 'Dermatologist',
                        ),
                        BuildInfoRow(
                          icon: Icons.phone,
                          label: 'Phone',
                          value: '+20 123 456 7890',
                        ),
                        BuildInfoRow(
                          icon: Icons.location_on,
                          label: 'Clinic Address',
                          value: '123 Nile Street, Cairo',
                        ),
                        BuildInfoRow(
                          icon: Icons.access_time,
                          label: 'Experience',
                          value: '8 years',
                        ),
                        BuildInfoRow(
                          icon: Icons.attach_money,
                          label: 'Session Fee',
                          value: 'EGP 300',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onTap: () {
                      SupAuthService.instance.signOut();
                    },
                    text: 'Log Out',
                    width: 200,
                  ),
                ],
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(HugeIcons.strokeRoundedSettings01, size: 27),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: 60,
                left: (screenWidth - 115) / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    'https://sesjzerlawpywdufplrw.supabase.co/storage/v1/object/public/images/profile/b5408107-0a2e-4634-a15f-76135cdb4487',
                    height: 115,
                    width: 115,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
