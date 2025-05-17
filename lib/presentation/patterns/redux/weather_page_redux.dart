import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weather_app/packages/domain/data/entity/exceptions.dart';
import 'package:weather_app/presentation/model/ui_weather.dart';
import 'package:weather_app/presentation/patterns/redux/weather_action_redux.dart';
import 'package:weather_app/presentation/patterns/redux/weather_state_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherPageRedux extends StatefulWidget {

  @override
  _WeatherPageRedux createState() => _WeatherPageRedux();
}

class _WeatherPageRedux extends State<WeatherPageRedux> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<WeatherState, _WeatherViewModel>(
        onInit: (store) => store.dispatch(FetchWeatherAction()),
        converter: (store) => _WeatherViewModel.fromStore(store),
        builder: (context, vm) {
          return _handleWeather(context, vm);
        }
      )
    );
  }

  Widget _handleWeather(BuildContext context, _WeatherViewModel vm) {
    if (vm.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      switch (vm.error.runtimeType) {
        case LocationDisabledException _:
          return Center(
            child: Text(AppLocalizations.of(context)!.locationDisabled),
          );
        case LocationPermissionDeniedException _:
          return Center(
            child: Text(AppLocalizations.of(context)!.locationPermissionsDenied),
          );
        case LocationPermissionDeniedForeverException _:
          return Center(
            child: Text(
              AppLocalizations.of(context)!.locationPermissionsDeniedForever,
              textAlign: TextAlign.center,
            ),
          );
        default:
          return Center(
            child: Text(
              vm.error.toString(),
              textAlign: TextAlign.center,
            ),
          );
      }
    }

    if (vm.weather != null) {
      final uiWeather = vm.weather!;
      return RefreshIndicator(
        onRefresh: () async {
          vm.fetchWeather();
        },
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    uiWeather.main.backgroundStart,
                    uiWeather.main.backgroundEnd,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    uiWeather.city,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.weatherTemperature(
                        uiWeather.temperature
                    ),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.feelsLike(
                        uiWeather.feelsLike
                    ),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    uiWeather.description,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 60),
                  Icon(
                    uiWeather.main.icon,
                    color: Colors.white,
                    size: 100,
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Card(
                      color: Colors.white.withValues(alpha: 0.8),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.wind(
                                  uiWeather.wind
                              ),
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              AppLocalizations.of(context)!.humidity(
                                  uiWeather.humidity
                              ),
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              AppLocalizations.of(context)!.sunrise(
                                  uiWeather.sunrise
                              ),
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              AppLocalizations.of(context)!.sunset(
                                  uiWeather.sunset
                              ),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      );
    }

    return Center(
      child: Text(AppLocalizations.of(context)!.weatherTitle)
    );
  }
}

class _WeatherViewModel {
  final bool isLoading;
  final Exception? error;
  final UiWeather? weather;
  final VoidCallback fetchWeather;

  _WeatherViewModel({
    required this.isLoading,
    required this.error,
    required this.weather,
    required this.fetchWeather,
  });

  static _WeatherViewModel fromStore(Store<WeatherState> store) {
    return _WeatherViewModel(
      isLoading: store.state.isLoading,
      error: store.state.error,
      weather: store.state.weather,
      fetchWeather: () => {
        store.dispatch(ReloadWeatherAction())
      },
    );
  }
}
