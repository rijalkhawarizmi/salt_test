

import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/home/data/models/home_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../presentation/view/home.dart';
import '../repositories/home_repository.dart';

class GetHome extends UsecaseWithParams<List<HomeModel>,CreateHomeParams>{

  const GetHome(this._homeRepository);
  final HomeRepository _homeRepository;
  
  @override 
  ResultFuture<List<HomeModel>> call(CreateHomeParams createHomeParams)async=>_homeRepository.getListHome(countryID: createHomeParams.countryID,search: createHomeParams.search,category: createHomeParams.category);

}

class CreateHomeParams extends Equatable {
  final String countryID;
  final String? search;
  final String? category;
  

  const CreateHomeParams(
      {required this.countryID,this.search,required this.category});
  
  
  @override
  // TODO: implement props
  List<Object?> get props => [countryID,search,category];
}