import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/packages/domain/data/entity/exceptions.dart';
import 'package:weather_app/presentation/patterns/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/patterns/bloc/weather_event.dart';
import 'package:weather_app/presentation/patterns/bloc/weather_state.dart';

class WeatherBlocView extends StatelessWidget {
  const WeatherBlocView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<WeatherBloc>().add(GetWeatherEvent());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        state.weather.main.backgroundStart,
                        state.weather.main.backgroundEnd,
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
                        state.weather.city,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.weatherTemperature(
                            state.weather.temperature
                        ),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.feelsLike(
                            state.weather.feelsLike
                        ),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.weather.description,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 60),
                      Icon(
                        state.weather.main.icon,
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
                                    state.weather.wind
                                  ),
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.humidity(
                                      state.weather.humidity
                                  ),
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.sunrise(
                                      state.weather.sunrise
                                  ),
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.sunset(
                                      state.weather.sunset
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
          } else if (state is WeatherError) {
            if (state.throwable is LocationDisabledException) {
              return Center(
                child: Text(AppLocalizations.of(context)!.locationDisabled)
              );
            } else if (state.throwable is LocationPermissionDeniedException) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.locationPermissionsDenied
                )
              );
            } else if (state.throwable is LocationPermissionDeniedForeverException) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.locationPermissionsDeniedForever,
                  textAlign: TextAlign.center,
                )
              );
            } else {
              return Center(
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                )
              );
            }
          }
          return Center(
            child: Text(AppLocalizations.of(context)!.welcomeTitle)
          );
        },
      ),
    );
  }
}
