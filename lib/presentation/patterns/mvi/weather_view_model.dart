
import 'package:flutter/material.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'weather_state.dart';
import 'weather_intent.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherState _state = WeatherState.initial();
  WeatherState get state => _state;
  final FetchWeatherUseCase _fetchWeather;
  final DomainToUiMapper _mapper;

  WeatherViewModel(this._fetchWeather, this._mapper);

  void dispatch(WeatherIntent intent) async {
    switch (intent) {
      case LoadWeather():
      case RefreshWeather():
        await _loadWeather();
        break;
    }
  }

  Future<void> _loadWeather() async {
    _updateState(_state.copyWith(isLoading: true, error: null));
    try {
      final weather = await _fetchWeather();
      final uiWeather = _mapper.map(weather);
      _updateState(
        _state.copyWith(isLoading: false, uiWeather: uiWeather),
      );
    } catch (e) {
      _updateState(_state.copyWith(isLoading: false, error: e as Exception));
    }
  }

  void _updateState(WeatherState newState) {
    _state = newState;
    notifyListeners();
  }
}
