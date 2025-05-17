class NetworkWeather {
  final String city;
  final int temperature;
  final int feelsLike;
  final int humidity;
  final String description;
  final double wind;
  final String main;
  final int sunrise;
  final int sunset;

  NetworkWeather({
    required this.city,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.description,
    required this.wind,
    required this.main,
    required this.sunrise,
    required this.sunset,
  });

  factory NetworkWeather.fromJson(Map<String, dynamic> json) {
    return NetworkWeather(
      city: json[_nameKey],
      temperature: json[_mainKey][_tempKey].toInt(),
      feelsLike: json[_mainKey][_feelsLikeKey].toInt(),
      humidity: json[_mainKey][_humidityKey].toInt(),
      description: json[_weatherKey][0][_descriptionKey],
      wind: json[_windKey][_speedKey],
      main: json[_weatherKey][0][_mainKey],
      sunrise: json[_sysKey][_sunriseKey],
      sunset: json[_sysKey][_sunsetKey],
    );
  }

  static const String _nameKey = 'name';
  static const String _mainKey = 'main';
  static const String _weatherKey = 'weather';
  static const String _windKey = 'wind';
  static const String _sysKey = 'sys';
  static const String _tempKey = 'temp';
  static const String _feelsLikeKey = 'feels_like';
  static const String _humidityKey = 'humidity';
  static const String _descriptionKey = 'description';
  static const String _speedKey = 'speed';
  static const String _sunriseKey = 'sunrise';
  static const String _sunsetKey = 'sunset';
}
