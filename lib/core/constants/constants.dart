import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static const String baseUrl = 'http://api.openweathermap.org/data/2.5';
  static String apiKey = dotenv.get('OPEN_WEATHER_API_KEY');
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'https://openweathermap.org/img/wn/$iconCode@2x.png';
}
