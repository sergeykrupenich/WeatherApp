import 'package:weather_app/presentation/patterns/redux/weather_action_redux.dart';
import 'package:weather_app/presentation/patterns/redux/weather_state_redux.dart';

WeatherState weatherReducer(WeatherState state, dynamic action) {
  if (action is LoadingWeatherAction) {
    return state.copyWith(isLoading: true, weather: null, error: null);
  } else if (action is WeatherLoadedAction) {
    return state.copyWith(
        isLoading: false,
        weather: action.weather,
    );
  } else if (action is WeatherErrorAction) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
    );
  }
  return state;
}
