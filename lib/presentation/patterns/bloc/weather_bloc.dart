import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherUseCase _fetchWeather;
  final DomainToUiMapper _mapper;

  WeatherBloc(this._fetchWeather, this._mapper) : super(WeatherInitial()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await _fetchWeather();
        emit(WeatherLoaded(_mapper.map(weather)));
      } catch (e) {
        emit(WeatherError(e.toString(), e as Exception));
      }
    });
  }
}
