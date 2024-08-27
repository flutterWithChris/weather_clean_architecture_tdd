import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_clean_architecture_tdd/core/error/failure.dart';
import 'package:weather_clean_architecture_tdd/data/repositories/weather_repository_impl.dart';
import 'package:weather_clean_architecture_tdd/domain/entities/weather.dart';
import 'package:weather_clean_architecture_tdd/domain/usecases/get_current_weather.dart';
import 'package:weather_clean_architecture_tdd/presentation/bloc/bloc/weather_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  String testCityName = 'New York';

  var testWeatherEntity = const WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    humidity: 70,
    pressure: 1009,
  );

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  test('Initial state should be empty', () {
    expect(weatherBloc.state, WeatherInitial());
  });

  blocTest<WeatherBloc, WeatherState>(
    'WeatherLoaded state emits on data',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => Right(testWeatherEntity));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(OnCityChanged(cityName: testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      WeatherLoaded(result: testWeatherEntity),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'WeatherLoadFailed emits on error',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
          (_) async => const Left(ServerFailure('An error occured.')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(OnCityChanged(cityName: testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailure('Server failure.'),
    ],
  );
}
