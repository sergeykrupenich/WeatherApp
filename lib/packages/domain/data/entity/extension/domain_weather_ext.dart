import 'package:weather_app/packages/data/model/network_weather.dart';

import '../weather.dart';

extension WeatherMapper on NetworkWeather {
  Weather toDomain() {
    return Weather(
      city: city,
      temperature: temperature,
      feelsLike: feelsLike,
      humidity: humidity,
      description: description,
      wind: wind,
      main: main,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}