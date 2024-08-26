// Testing:
// 1. Is model that we created equal to the entities at domain layer
// 2. Does fromJSON return valid model?
// 3. Does toJSON return appropriate JSON map?
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_clean_architecture_tdd/data/models/weather_model.dart';
import 'package:weather_clean_architecture_tdd/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'London',
    main: 'Clouds',
    description: 'broken clouds',
    iconCode: '04n',
    temperature: 288.7,
    pressure: 1018,
    humidity: 86,
  );

  group('Weather Model Tests', () {
    test('Model equal to WeatherEntity', () async {
      expect(testWeatherModel, isA<WeatherEntity>());
    });

    test('WeatherModel.fromJson returns WeatherEntity', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

      // act
      final result = WeatherModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testWeatherModel));
    });

    test('WeatherModel.toJson returns WeatherEntity', () {
      final result = testWeatherModel.toJson();

      final expectedJsonMap = {
        "weather": [
          {"main": "Clouds", "description": "broken clouds", "icon": "04n"}
        ],
        "main": {
          "temp": 288.7,
          "pressure": 1018,
          "humidity": 86,
        },
        "name": "London",
      };

      expect(result, equals(expectedJsonMap));
    });
  });
}
