import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_clean_architecture_tdd/core/constants/constants.dart';
import 'package:weather_clean_architecture_tdd/core/error/exception.dart';
import 'package:weather_clean_architecture_tdd/data/data_sources/remote_data_source.dart';
import 'package:weather_clean_architecture_tdd/data/models/weather_model.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() async {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
    await dotenv.load();
  });

  group('Get Current Weather (API)', () {
    test('should return weather model from response code 200', () async {
      String testCityName = 'London';
      when(
        mockHttpClient.get(
          Uri.parse(
            Urls.currentWeatherByName(testCityName),
          ),
        ),
      ).thenAnswer((_) async => http.Response(
          readJson('helpers/dummy_data/dummy_weather_response.json'), 200));

      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      expect(result, isA<Right>());
    });

    test('should return error from response code 404', () async {
      String testCityName = 'London';
      when(
        mockHttpClient.get(
          Uri.parse(
            Urls.currentWeatherByName(testCityName),
          ),
        ),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      expect(result, isA<Left>());
    });
  });
}
