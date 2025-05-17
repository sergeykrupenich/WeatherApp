import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/packages/domain/data/entity/weather.dart';
import 'package:weather_app/presentation/model/ui_weather.dart';
import 'package:weather_app/presentation/model/ui_weather_main.dart';
import 'package:weather_icons/weather_icons.dart';
// import 'package:injectable/injectable.dart';

// @LazySingleton() //(as: DomainToUiMapper)
class DomainToUiMapper {
  static final UiWeatherMain _cloudyUiWeatherMain = UiWeatherMain(
    backgroundStart: Colors.grey.shade300,
    backgroundEnd: Colors.grey.shade600,
    icon: WeatherIcons.day_cloudy,
  );
  static final HashMap<String, UiWeatherMain> _weatherMains = HashMap()
    ..[_cloudsKey] = _cloudyUiWeatherMain
    ..[_rainKey] = UiWeatherMain(
      backgroundStart: Colors.blueGrey.shade800,
      backgroundEnd: Colors.blueGrey.shade900,
      icon: WeatherIcons.rain,
    )
    ..[_clearKey] = UiWeatherMain(
      backgroundStart: Colors.blue.shade400,
      backgroundEnd: Colors.blue.shade800,
      icon: WeatherIcons.day_sunny,
    );

  UiWeather map(final Weather weather) {
    return UiWeather(
      city: weather.city,
      temperature: weather.temperature,
      feelsLike: weather.feelsLike,
      humidity: weather.humidity,
      description: weather.description,
      wind: weather.wind,
      main: _weatherMains[weather.main] ?? _cloudyUiWeatherMain,
      sunrise: _utcToTimeString(weather.sunrise),
      sunset: _utcToTimeString(weather.sunset),
    );
  }

  String _utcToTimeString(final int timeUtc) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(
        timeUtc * _millSec,
        isUtc: true
    );
    return DateFormat.Hms().format(date.toLocal());
  }

  static const _millSec = 1000;
  static const _cloudsKey = 'Clouds';
  static const _rainKey = 'Rain';
  static const _clearKey = 'Clear';
}
