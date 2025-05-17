import 'package:weather_app/presentation/model/ui_weather.dart';

class WeatherState {
  final UiWeather? weather;
  final bool isLoading;
  final Exception? error;

  WeatherState({this.weather, this.isLoading = false, this.error});

  factory WeatherState.initLoading({
      UiWeather? weather,
      bool? isLoading,
      Exception? error,
  }) {
    return WeatherState(
      weather: null,
      isLoading: true,
      error: null,
    );
  }

  WeatherState copyWith({
    UiWeather? weather,
    bool? isLoading,
    Exception? error,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
