part of 'doctor_feedback_cubit.dart';

@immutable
sealed class DoctorFeedbackState {}

class DoctorFeedbackInitial extends DoctorFeedbackState {}

class DoctorFeedbackLoading extends DoctorFeedbackState {}

class DoctorFeedbackLoaded extends DoctorFeedbackState {
  final List<DoctorFeedbackModel> feedbackList;
  DoctorFeedbackLoaded({required this.feedbackList});
}

class DoctorFeedbackFailed extends DoctorFeedbackState {
  final String errorMessage;
  DoctorFeedbackFailed({required this.errorMessage});
}
