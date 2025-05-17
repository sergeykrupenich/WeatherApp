import 'package:weather_app/presentation/model/ui_weather.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final UiWeather weather;
  WeatherLoaded(this.weather);
}

class WeatherError extends WeatherState {
  final String message;
  final Exception throwable;

  WeatherError(this.message, this.throwable);
}
