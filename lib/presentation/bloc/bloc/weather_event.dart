part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class OnCityChanged extends WeatherEvent {
  final String cityName;
  const OnCityChanged({required this.cityName});
  @override
  List<Object> get props => [cityName];
}
