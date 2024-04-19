import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/src/home/data/models/home_model.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/repositories/home_repository.dart';
import '../../presentation/view/home.dart';
import '../datasources/home_remote_data_sources.dart';

class HomeRepositoryImplementation extends HomeRepository {
  HomeRepositoryImplementation(this._homeDataSource);
  HomeRemoteDataSource _homeDataSource;
  @override
  ResultFuture<List<HomeModel>> getListHome({required String countryID,String? search,String? category}) async {
    // TODO: implement getListHome
    try {
      final result = await _homeDataSource.getListHome(countryID: countryID,search: search,category: category);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
