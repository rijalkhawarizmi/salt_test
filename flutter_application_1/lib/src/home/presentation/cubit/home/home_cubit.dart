import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/home_model.dart';
import '../../../domain/usecases/get_home.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHome) : super(HomeInitial());

  final GetHome _getHome;

  Future<void> getListHome({required String countryID,String? search,String? category}) async {
    emit(HomeLoading());
    final result = await _getHome(CreateHomeParams(countryID: countryID, search: search, category: category));
    result.fold(
      (failed) => emit(HomeFailed(message: failed.errorMessage)),
      (success) => emit(
        HomeSuccess(listHome: success),
      ),
    );
  }
}
