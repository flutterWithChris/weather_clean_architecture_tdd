part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherEmpty extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherEntity result;
  const WeatherLoaded({required this.result});
  @override
  // TODO: implement props
  List<Object> get props => [result];
}

final class WeatherLoadFailure extends WeatherState {
  final String message;
  const WeatherLoadFailure(this.message);
  @override
  List<Object> get props => [message];
}
