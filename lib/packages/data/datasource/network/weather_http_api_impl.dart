import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/packages/data/datasource/network/weather_http_api.dart';
import 'package:weather_app/packages/data/model/network_weather.dart';

class WeatherApiServiceImpl implements WeatherHttpApi {
  static const String _apiKey = 'WEATHER_API_KEY';
  static const String _baseUrlKey = 'BASE_URL';
  static const String _weatherServiceKey = 'WEATHER_SERVICE';
  static const String _apiVersionKey = 'API_VERSION';

  static final _key = dotenv.env[_apiKey];
  static final _baseUrl = dotenv.env[_baseUrlKey];
  static final _apiVersion = dotenv.env[_apiVersionKey];
  static final _apiWeather = dotenv.env[_weatherServiceKey];

  @override
  Future<NetworkWeather> get(String city) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/$_apiVersion$_apiWeather?q=$city&appid=$_key&units=metric'
      ),
    );

    if (response.statusCode == 200) {
      return NetworkWeather.fromJson(
          json.decode(response.body)
      );
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
