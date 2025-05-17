import 'package:flutter/cupertino.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_model.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_msg.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_update.dart';

class WeatherNotifier extends ChangeNotifier {
  WeatherModel _model = WeatherModel();
  WeatherModel get model => _model;

  late final WeatherUpdate _updater;

  WeatherNotifier(FetchWeatherUseCase fetchWeather, DomainToUiMapper mapper,) {
    _updater = WeatherUpdate(fetchWeather, mapper, _model, _setModel);
    _updater.update(FetchWeather());
  }

  void _setModel(WeatherModel newModel) {
    _model = newModel;
    notifyListeners();
  }

  Future<void> dispatch(WeatherMsg msg) => _updater.update(msg);
}
