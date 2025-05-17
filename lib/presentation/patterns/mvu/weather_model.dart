import 'package:weather_app/presentation/model/ui_weather.dart';

class WeatherModel {
  final UiWeather? model;
  final bool isLoading;
  final Exception? error;

  WeatherModel({
    this.model,
    this.isLoading = false,
    this.error,
  });

  WeatherModel copyWith({
    bool? isLoading,
    UiWeather? data,
    Exception? error,
  }) {
    return WeatherModel(
      isLoading: isLoading ?? this.isLoading,
      model: data ?? model,
      error: error ?? this.error,
    );
  }
}
