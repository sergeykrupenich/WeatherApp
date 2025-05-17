import 'package:weather_app/core/di/service_locator.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'package:weather_app/presentation/patterns/viper/weather_entity_viper.dart';

abstract class WeatherInteractorViper {
  Future<WeatherEntityViper> fetchWeather();
}

class WeatherInteractorViperImpl implements WeatherInteractorViper {

  final FetchWeatherUseCase _fetchWeather = getIt();
  final DomainToUiMapper _mapper = getIt();

  @override
  Future<WeatherEntityViper> fetchWeather() async {
    final weather = await _fetchWeather();
    final uiWeather = _mapper.map(weather);

    return WeatherEntityViper(weather: uiWeather);
  }
}



