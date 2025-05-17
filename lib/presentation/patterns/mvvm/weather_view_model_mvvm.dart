import 'package:flutter/cupertino.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'package:weather_app/presentation/model/ui_weather.dart';

class WeatherViewModelMvvm extends ChangeNotifier {
  UiWeather? _weather;
  UiWeather? get weather => _weather;

  Exception? _error;
  Exception? get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final FetchWeatherUseCase _fetchWeather;
  final DomainToUiMapper _mapper;

  WeatherViewModelMvvm(this._fetchWeather, this._mapper);

  Future<void> fetchWeather() async {
    _isLoading = true;

    try {
      final weather = await _fetchWeather();
      _weather = _mapper.map(weather);
      _error = null;
    } catch (exception) {
      _error = exception as Exception;
    }

    _isLoading = false;
    notifyListeners();
  }
}