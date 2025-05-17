import 'package:weather_app/core/di/service_locator.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'package:weather_app/presentation/patterns/mvp/weather_model_mvp.dart';

abstract class WeatherViewContract {
  void showLoading();

  void showWeather(WeatherModelMvp weather);

  void showError(Exception throwable);
}

class WeatherPresenter {
  final WeatherViewContract _view;
  final FetchWeatherUseCase _fetchWeather = getIt();
  final DomainToUiMapper _mapper = getIt();

  WeatherPresenter(this._view);

  Future<void> loadWeather() async {
    _view.showLoading();

    try {
      final weather = await _fetchWeather();
      final uiWeather = _mapper.map(weather);

      _view.showWeather(
        WeatherModelMvp(uiWeather)
      );
    } catch (e) {
      _view.showError(e as Exception);
    }
  }
}
