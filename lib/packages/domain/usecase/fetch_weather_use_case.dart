import 'package:weather_app/packages/domain/data/entity/weather.dart';

abstract class FetchWeatherUseCase {
  Future<Weather> call();
}
