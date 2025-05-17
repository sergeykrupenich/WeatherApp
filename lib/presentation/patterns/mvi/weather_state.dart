import 'package:weather_app/presentation/model/ui_weather.dart';

class WeatherState {
  final bool isLoading;
  final UiWeather? uiWeather;
  final Exception? error;

  const WeatherState({
    this.isLoading = false,
    this.uiWeather,
    this.error,
  });

  WeatherState copyWith({
    bool? isLoading,
    UiWeather? uiWeather,
    Exception? error,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      uiWeather: uiWeather ?? this.uiWeather,
      error: error,
    );
  }

  factory WeatherState.initial() => const WeatherState();
}
