import 'package:weather_app/packages/domain/data/entity/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather();
}


