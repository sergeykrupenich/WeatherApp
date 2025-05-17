import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/packages/domain/data/entity/exceptions.dart';
import 'package:weather_app/presentation/patterns/mvvm/weather_view_model_mvvm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherViewMvvm extends StatelessWidget {
  const WeatherViewMvvm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModelMvvm>(context);

    return Scaffold(
        body: _handleWeather(context, viewModel)
    );
  }

  Widget _handleWeather(BuildContext context, WeatherViewModelMvvm viewModel) {
    if (viewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      switch (viewModel.error.runtimeType) {
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
              viewModel.error.toString(),
              textAlign: TextAlign.center,
            ),
          );
      }
    }

    if (viewModel.weather != null) {
      final uiWeather = viewModel.weather!;
      return RefreshIndicator(
        onRefresh: () async {
          viewModel.fetchWeather();
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