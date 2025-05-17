import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'package:weather_app/presentation/patterns/redux/weather_reducer_redux.dart';
import 'package:weather_app/presentation/patterns/redux/weather_state_redux.dart';
import 'package:weather_app/presentation/patterns/redux/weather_action_redux.dart';

final store = Store<WeatherState>(
  weatherReducer,
  initialState: WeatherState.initLoading(),
  middleware: [weatherMiddleware],
);

final fetchWeatherUseCase = GetIt.instance<FetchWeatherUseCase>();
final mapper = GetIt.instance<DomainToUiMapper>();

Middleware<WeatherState> weatherMiddleware =
    (Store<WeatherState> store, dynamic action, NextDispatcher next) async {

  if (action is FetchWeatherAction || action is ReloadWeatherAction) {
    if (action is ReloadWeatherAction) {
      store.dispatch(LoadingWeatherAction());
    }
    try {
      final weather = await fetchWeatherUseCase();
      final uiWeather = mapper.map(weather);

      store.dispatch(WeatherLoadedAction(uiWeather));
    } catch (e) {
      store.dispatch(WeatherErrorAction(e as Exception));
    }
  }

  next(action); // Always call next
};
