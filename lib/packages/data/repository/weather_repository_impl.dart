import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/packages/data/datasource/network/weather_http_api.dart';
import 'package:weather_app/packages/domain/data/entity/exceptions.dart';
import 'package:weather_app/packages/domain/data/entity/extension/domain_weather_ext.dart';
import 'package:weather_app/packages/domain/data/entity/weather.dart';
import 'package:weather_app/packages/domain/data/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {

  final WeatherHttpApi _httpApi;

  WeatherRepositoryImpl(this._httpApi);

  // TODO: could be split
  @override
  Future<Weather> fetchWeather() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDisabledException();
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requestedPermissions = await Geolocator.requestPermission();
      if (requestedPermissions == LocationPermission.denied) {
        throw LocationPermissionDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedForeverException();
    }

    final position = await Geolocator.getCurrentPosition();
    final placeMarks = await placemarkFromCoordinates(
        position.latitude, position.longitude
    );
    final city = placeMarks.first.locality;
    final networkWeather = await _httpApi.get(
      city ?? ""
    );

    return networkWeather.toDomain();
  }
}
