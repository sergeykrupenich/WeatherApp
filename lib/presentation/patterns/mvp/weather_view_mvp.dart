import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/packages/domain/data/entity/exceptions.dart';
import 'package:weather_app/presentation/patterns/mvp/weather_model_mvp.dart';
import 'package:weather_app/presentation/patterns/mvp/weather_presenter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherPageMvp extends StatefulWidget {
  const WeatherPageMvp({super.key});

  @override
  State<WeatherPageMvp> createState() => _WeatherPageMvpState();
}

class _WeatherPageMvpState extends State<WeatherPageMvp> implements WeatherViewContract {
  late WeatherPresenter _presenter;
  bool _isLoading = false;
  WeatherModelMvp? _weather;
  Exception? _error;

  @override
  void initState() {
    super.initState();
    _presenter = WeatherPresenter(this);
    _presenter.loadWeather();
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
      _error = null;
      _weather = null;
    });
  }

  @override
  void showWeather(WeatherModelMvp weather) {
    setState(() {
      _isLoading = false;
      _weather = weather;
    });
  }

  @override
  void showError(Exception throwable) {
    setState(() {
      _isLoading = false;
      _error = throwable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _handleWeather(context)
    );
  }

  Widget _handleWeather(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      return _handleError(_error!, context);
    } else if (_weather != null) {
      final uiWeather = _weather!.uiWeather;
      return RefreshIndicator(
        onRefresh: () async {
          _presenter.loadWeather();
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

  Center _handleError(Exception error, BuildContext context) {
    switch (error.runtimeType) {
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
            error.toString(),
            textAlign: TextAlign.center,
          ),
        );
    }
  }
}
