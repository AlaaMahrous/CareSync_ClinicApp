import 'package:bloc/bloc.dart';
import 'package:clinic/core/models/doctor_card_model.dart';
import 'package:clinic/core/services/supabase/doctor_service.dart';
import 'package:meta/meta.dart';

part 'doctors_list_state.dart';

class DoctorsListCubit extends Cubit<DoctorsListState> {
  DoctorsListCubit() : super(DoctorsListInitial());

  Future<void> fetchDoctors() async {
    emit(DoctorListLoading());
    try {
      List<DoctorCardModel> result =
          await DoctorService().getDoctorsWithRatingCard();
      emit(DoctorListLoaded(result));
    } on Exception catch (e, stack) {
      emit(DoctorListLoadedFaild('$e $stack'));
    }
  }
}
