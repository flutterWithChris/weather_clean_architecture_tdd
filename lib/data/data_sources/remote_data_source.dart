import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture_tdd/core/constants/constants.dart';
import 'package:weather_clean_architecture_tdd/core/error/exception.dart';
import 'package:weather_clean_architecture_tdd/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<Either<ServerException, WeatherModel>> getCurrentWeather(
      String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<ServerException, WeatherModel>> getCurrentWeather(
      String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return Right(WeatherModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left(ServerException());
    }
  }
}
