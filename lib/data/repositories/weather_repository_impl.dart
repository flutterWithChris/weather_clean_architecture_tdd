import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture_tdd/core/error/failure.dart';
import 'package:weather_clean_architecture_tdd/domain/entities/weather.dart';
import 'package:weather_clean_architecture_tdd/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) {
    // TODO: implement getCurrentWeather
    throw UnimplementedError();
  }
}
