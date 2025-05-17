class Weather {
  final String city;
  final int temperature;
  final int feelsLike;
  final int humidity;
  final String description;
  final double wind;
  final String main;
  final int sunrise;
  final int sunset;

  Weather({
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
}
