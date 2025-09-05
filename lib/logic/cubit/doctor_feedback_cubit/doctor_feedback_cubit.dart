import 'package:bloc/bloc.dart';
import 'package:clinic/core/models/doctor_feedback_model.dart';
import 'package:clinic/core/services/supabase/doctor_service.dart';
import 'package:meta/meta.dart';

part 'doctor_feedback_state.dart';

class DoctorFeedbackCubit extends Cubit<DoctorFeedbackState> {
  DoctorFeedbackCubit() : super(DoctorFeedbackInitial());

  Future<void> getDoctorFeedback(int doctorId) async {
    emit(DoctorFeedbackLoading());
    try {
      final feedbackList = await DoctorService().getDoctorFeedback(doctorId);
      emit(DoctorFeedbackLoaded(feedbackList: feedbackList));
    } on Exception catch (e, stack) {
      emit(DoctorFeedbackFailed(errorMessage: '$e\n$stack'));
    }
  }
}
