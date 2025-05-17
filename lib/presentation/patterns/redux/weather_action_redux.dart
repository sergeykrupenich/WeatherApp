import 'package:weather_app/presentation/model/ui_weather.dart';

class FetchWeatherAction {}

class ReloadWeatherAction {}

class LoadingWeatherAction {}

class WeatherLoadedAction {
  final UiWeather weather;
  WeatherLoadedAction(this.weather);
}

class WeatherErrorAction {
  final Exception error;
  WeatherErrorAction(this.error);
}
