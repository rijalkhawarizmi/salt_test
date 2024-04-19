import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/utils/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/typedef.dart';
import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeModel>> getListHome({required String countryID,String? search,String? category});
}

class HomeRemoteDataSrcImpl implements HomeRemoteDataSource {
  HomeRemoteDataSrcImpl(this._dio);
  Dio _dio;

  @override
  Future<List<HomeModel>> getListHome({required String countryID,String? search,String? category}) async {
    try {
      final response = await _dio.get('$baseUrl?country=$countryID&q=$search&category=$category&apiKey=$apiKey');

      if (response.statusCode == 200) {
        print('hahah ${response.data}');
        return List<DataMap>.from(response.data['articles'] as List)
            .map((homeData) => HomeModel.fromJson(homeData))
            .toList();
      } else {
        throw ApiException(
            message: response.data, statusCode: response.statusCode!);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
