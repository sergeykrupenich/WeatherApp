import 'package:weather_app/presentation/model/ui_weather.dart';

sealed class WeatherMsg {}

class FetchWeather extends WeatherMsg {}

class WeatherLoaded extends WeatherMsg {
  final UiWeather data;
  WeatherLoaded(this.data);
}

class WeatherFailed extends WeatherMsg {
  final Exception error;
  WeatherFailed(this.error);
}
