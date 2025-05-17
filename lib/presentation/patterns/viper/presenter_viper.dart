import 'package:weather_app/presentation/model/ui_weather.dart';

import 'interactor_viper.dart';

abstract class WeatherViewViper {
  void showLoading();
  void showWeather(UiWeather weather);
  void showError(Exception exception);
}

class WeatherPresenter {
  final WeatherViewViper view;
  final WeatherInteractorViper interactor;

  WeatherPresenter({required this.view, required this.interactor});

  void onLoadWeather() async {
    view.showLoading();

    try {
      final weather = await interactor.fetchWeather();
      view.showWeather(weather.weather);
    } catch (e) {
      view.showError(e as Exception);
    }
  }
}




