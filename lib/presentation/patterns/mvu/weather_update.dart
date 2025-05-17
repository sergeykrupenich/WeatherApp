import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_model.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_msg.dart';

typedef UpdateFn = Future<void> Function(WeatherMsg msg);

class WeatherUpdate {
  WeatherModel _model;

  final FetchWeatherUseCase _fetchWeather;
  final DomainToUiMapper _mapper;

  final void Function(WeatherModel) setModel;

  WeatherUpdate(this._fetchWeather, this._mapper, this._model, this.setModel);

  Future<void> update(WeatherMsg msg,) async {
    switch (msg) {
      case FetchWeather():
        setModel(_model.copyWith(isLoading: true, error: null));
        try {
          final data = await _fetchWeather();
          final uiData = _mapper.map(data);
          setModel(_model.copyWith(isLoading: false, data: uiData));
        } catch (e) {
          setModel(_model.copyWith(isLoading: false, error: e as Exception));
        }
        break;
      case WeatherLoaded(:final data):
        setModel(_model.copyWith(data: data, isLoading: false));
        break;
      case WeatherFailed(:final error):
        setModel(_model.copyWith(error: error, isLoading: false));
        break;
    }
  }
}
