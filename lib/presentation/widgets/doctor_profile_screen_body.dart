import 'package:clinic/core/models/doctor_profile_model.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/auth/sup_auth_service.dart';
import 'package:clinic/presentation/widgets/build_info_row.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hugeicons/hugeicons.dart';

class DoctorProfileScreenBody extends StatelessWidget {
  const DoctorProfileScreenBody({super.key, required this.doctorModel});
  final DoctorProfileModel doctorModel;

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
                  const SizedBox(height: 60),
                  Text(
                    doctorModel.doctorName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RatingBarIndicator(
                    rating: doctorModel.averageRating,
                    itemCount: 5,
                    itemSize: 18,
                    direction: Axis.horizontal,
                    itemBuilder:
                        (context, _) => const Icon(
                          Icons.star,
                          color: ColorsManager.mainAppColor,
                        ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        BuildInfoRow(
                          icon: Icons.info_outline,
                          label: 'Bio',
                          value: doctorModel.info,
                        ),
                        BuildInfoRow(
                          icon: HugeIcons.strokeRoundedDoctor01,
                          label: 'Specialization ',
                          value: doctorModel.specialization,
                        ),
                        BuildInfoRow(
                          icon: Icons.phone,
                          label: 'Phone',
                          value: doctorModel.phone,
                        ),
                        BuildInfoRow(
                          icon: Icons.location_on,
                          label: 'Clinic Address',
                          value: doctorModel.address,
                        ),
                        BuildInfoRow(
                          icon: Icons.access_time,
                          label: 'Experience',
                          value: '${doctorModel.experience.ceil()} Years',
                        ),
                        BuildInfoRow(
                          icon: Icons.attach_money,
                          label: 'Session Fee',
                          value: '${doctorModel.consultationFee} USD',
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
                  icon: const Icon(HugeIcons.strokeRoundedEdit02, size: 27),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: 60,
                left: (screenWidth - 115) / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    doctorModel.imageUrl,
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
