// Testing:
// 1. Is model that we created equal to the entities at domain layer
// 2. Does fromJSON return valid model?
// 3. Does toJSON return appropriate JSON map?
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_clean_architecture_tdd/data/models/weather_model.dart';
import 'package:weather_clean_architecture_tdd/domain/entities/weather.dart';

void main() {
  const testWeatherModel = WeatherModel(
      cityName: 'New York',
      main: 'Cloudy',
      description: 'Cloudy day',
      iconCode: '011',
      temperature: 72,
      pressure: 3014,
      humidity: 50);

  test('Model equal to WeatherEntity', () async {
    expect(testWeatherModel, isA<WeatherEntity>());
  });
}
