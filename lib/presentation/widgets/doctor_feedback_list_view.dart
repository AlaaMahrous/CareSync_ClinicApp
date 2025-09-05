import 'package:clinic/core/models/doctor_feedback_model.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/doctor_feedback_cubit/doctor_feedback_cubit.dart';
import 'package:clinic/presentation/widgets/doctor_feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorFeedbackListView extends StatefulWidget {
  const DoctorFeedbackListView({super.key});

  @override
  State<DoctorFeedbackListView> createState() => _DoctorFeedbackListViewState();
}

class _DoctorFeedbackListViewState extends State<DoctorFeedbackListView> {
  // Dummy Data باستخدام DoctorFeedbackModel
  final List<DoctorFeedbackModel> feedbackList = [
    DoctorFeedbackModel(
      patientName: 'Alaa Mahrous',
      comment:
          'The video call quality was good, and the doctor was very patient while answering all my questions.',
      rating: 4,
    ),
    DoctorFeedbackModel(
      patientName: 'Omar Khaled',
      comment:
          'Dr. Ahmed explained everything clearly and made me feel very comfortable during the online session.',
      rating: 5,
    ),
    DoctorFeedbackModel(
      patientName: 'Sara Youssef',
      comment:
          'The consultation was smooth and professional. Very convenient to do it online.',
      rating: 4,
    ),
    DoctorFeedbackModel(
      patientName: 'Mohamed Ali',
      comment:
          'Great experience! He listened carefully and gave me the right treatment plan.',
      rating: 5,
    ),
    DoctorFeedbackModel(
      patientName: 'Nourhan Ibrahim',
      comment:
          'The doctor was kind and patient, but the session started a bit late.',
      rating: 3,
    ),
    DoctorFeedbackModel(
      patientName: 'Hassan Tarek',
      comment:
          'Even though it was online, I felt real care and support. Highly recommended.',
      rating: 4,
    ),
    DoctorFeedbackModel(
      patientName: 'Lina Adel',
      comment:
          'Very professional and respectful, I will definitely book another online session.',
      rating: 5,
    ),
  ];

  @override
  void initState() {
    context.read<DoctorFeedbackCubit>().getDoctorFeedback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorFeedbackCubit, DoctorFeedbackState>(
      builder: (context, state) {
        if (state is DoctorFeedbackLoading) {
          return const Center(
            child: CircularProgressIndicator(color: ColorsManager.mainAppColor),
          );
        } else if (state is DoctorFeedbackLoaded) {
          if (state.feedbackList.isEmpty) {
            return const Center(
              child: Text(
                "No feedback available",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.feedbackList.length,
            itemBuilder: (context, index) {
              final feedback = state.feedbackList[index];
              return DoctorFeedbackCard(feedback: feedback);
            },
          );
        } else if (state is DoctorFeedbackFailed) {
          return Center(
            child: Text(
              "Failed to load feedback:\n${state.errorMessage}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(
          child: Text(
            "No data yet, please wait...",
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }
}
