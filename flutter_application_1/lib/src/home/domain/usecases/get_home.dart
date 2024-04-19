

import 'package:flutter_application_1/src/home/data/models/home_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../presentation/view/home.dart';
import '../repositories/home_repository.dart';

class GetHome extends UsecaseWithoutParams<List<HomeModel>>{

  const GetHome(this._homeRepository);
  final HomeRepository _homeRepository;
  
  @override 
  ResultFuture<List<HomeModel>> call()async=>_homeRepository.getListHome();

}