import 'package:weather_app/packages/data/model/network_weather.dart';

abstract class WeatherHttpApi {
  Future<NetworkWeather> get(String city);
}
