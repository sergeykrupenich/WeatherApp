import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/packages/domain/data/entity/weather.dart';
import 'package:weather_app/packages/domain/data/repository/weather_repository.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';

class FetchWeatherUseCaseImpl implements FetchWeatherUseCase {
  final WeatherRepository _repository;

  FetchWeatherUseCaseImpl(this._repository);

  @override
  Future<Weather> call() {
    return _repository.fetchWeather();
  }
}
