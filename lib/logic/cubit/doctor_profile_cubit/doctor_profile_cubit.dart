import 'package:bloc/bloc.dart';
import 'package:clinic/core/models/doctor_profile_model.dart';
import 'package:clinic/core/services/supabase/doctor_service.dart';
import 'package:meta/meta.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit() : super(DoctorProfileInitial());

  getDoctorProfileData() async {
    emit(DoctorProfileLoading());
    try {
      DoctorProfileModel doctorModel = await DoctorService().getDoctorProfile(
        1,
      );
      emit(DoctorProfileLoaded(doctorModel: doctorModel));
    } on Exception catch (e, stack) {
      emit(DoctorProfileLoadingFaild(errorMessage: '$e\n$stack'));
    }
  }
}
