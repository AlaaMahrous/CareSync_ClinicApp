import 'package:bloc/bloc.dart';
import 'package:clinic/core/models/doctor_card_model.dart';
import 'package:clinic/core/services/supabase/doctor_service.dart';
import 'package:meta/meta.dart';

part 'doctors_list_state.dart';

class DoctorsListCubit extends Cubit<DoctorsListState> {
  DoctorsListCubit() : super(DoctorsListInitial());
  final int _pageSize = 10;
  int _currentPage = 0;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  List<DoctorCardModel> _allDoctors = [];
  List<DoctorCardModel> get doctors => _allDoctors;

  Future<void> fetchDoctors({bool isRefresh = false}) async {
    if (state is DoctorListLoading) return;

    if (isRefresh) {
      _currentPage = 0;
      _hasMore = true;
      _allDoctors = [];
      emit(DoctorsListInitial());
    }

    emit(DoctorListLoading());

    final from = _currentPage * _pageSize;
    final to = from + _pageSize - 1;

    final result = await DoctorService().getDoctorsWithRatingCard(
      from: from,
      to: to,
    );

    if (result.length < _pageSize) _hasMore = false;

    _allDoctors.addAll(result);
    _currentPage++;

    emit(DoctorListLoaded(_allDoctors));
  }
}
