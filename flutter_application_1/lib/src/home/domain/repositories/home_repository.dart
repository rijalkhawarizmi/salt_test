

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/home/data/models/home_model.dart';

import '../../../../core/utils/typedef.dart';
import '../../presentation/view/home.dart';

abstract class HomeRepository{
 const HomeRepository();

 

 ResultFuture<List<HomeModel>> getListHome(); 

}