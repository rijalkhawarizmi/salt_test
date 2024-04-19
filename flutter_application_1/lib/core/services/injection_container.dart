

import 'package:dio/dio.dart';
import 'package:flutter_application_1/src/home/data/datasources/home_remote_data_sources.dart';
import 'package:flutter_application_1/src/home/data/repositories/home_repository_implementation.dart';
import 'package:flutter_application_1/src/home/domain/repositories/home_repository.dart';
import 'package:flutter_application_1/src/home/domain/usecases/get_home.dart';
import 'package:flutter_application_1/src/home/presentation/cubit/home/home_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Dio _dio=Dio();



Future<void> init() async {
  sl..registerLazySingleton(() => _dio);

  sl..registerFactory(() => HomeCubit(sl()));
  sl..registerLazySingleton(() => GetHome(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImplementation(sl()));
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSrcImpl(sl()));
  
}
