import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/packages/domain/data/entity/exceptions.dart';
import 'package:weather_app/presentation/model/ui_weather.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_msg.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherMvuView extends StatelessWidget {

  const WeatherMvuView({super.key});

  @override
  Widget build(BuildContext context) {
    return _WeatherView();
  }
}

class _WeatherView extends StatelessWidget {

  const _WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherNotifier = context.watch<WeatherNotifier>();
    return Scaffold(
        body: _weather(context, weatherNotifier)
    );
  }

  Widget _weather(BuildContext context, WeatherNotifier weatherNotifier,) {
    if (weatherNotifier.model.error != null) {
      if (weatherNotifier.model.error is LocationDisabledException) {
        return Center(
            child: Text(AppLocalizations.of(context)!.locationDisabled)
        );
      } else if (weatherNotifier.model.error is LocationPermissionDeniedException) {
        return Center(
            child: Text(
                AppLocalizations.of(context)!.locationPermissionsDenied
            )
        );
      } else
      if (weatherNotifier.model.error is LocationPermissionDeniedForeverException) {
        return Center(
            child: Text(
              AppLocalizations.of(context)!.locationPermissionsDeniedForever,
              textAlign: TextAlign.center,
            )
        );
      } else {
        return Center(
            child: Text(
              weatherNotifier.model.error.toString(),
              textAlign: TextAlign.center,
            )
        );
      }
    }

    final UiWeather? uiWeather = weatherNotifier.model.model;
    if (weatherNotifier.model.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (uiWeather != null) {
      return RefreshIndicator(
        onRefresh: () async {
          weatherNotifier.dispatch(FetchWeather());
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
        child: Text(AppLocalizations.of(context)!.welcomeTitle)
    );
  }
}

