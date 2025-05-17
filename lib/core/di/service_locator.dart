import 'package:get_it/get_it.dart';
import 'package:weather_app/packages/data/datasource/network/weather_http_api.dart';
import 'package:weather_app/packages/data/datasource/network/weather_http_api_impl.dart';
import 'package:weather_app/packages/data/repository/weather_repository_impl.dart';
import 'package:weather_app/packages/domain/data/repository/weather_repository.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case_impl.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'package:weather_app/presentation/patterns/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/patterns/mvi/weather_view_model.dart';
import 'package:weather_app/presentation/patterns/mvvm/weather_view_model_mvvm.dart';
import 'package:weather_app/presentation/patterns/viper/interactor_viper.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<WeatherHttpApi>(() => WeatherApiServiceImpl());
  getIt.registerLazySingleton<WeatherRepository>(() =>
    WeatherRepositoryImpl(getIt())
  );
  getIt.registerLazySingleton<FetchWeatherUseCase>(() =>
    FetchWeatherUseCaseImpl(getIt())
  );
  getIt.registerLazySingleton(() => DomainToUiMapper());

  // TODO BloC
  getIt.registerFactory(() => WeatherBloc(getIt(), getIt()));

  // TODO WeatherUpdate could be also registered here

  // TODO MVU:
  getIt.registerLazySingleton(() => WeatherViewModel(getIt(), getIt()));

  // TODO MVVM:
  getIt.registerLazySingleton(() => WeatherViewModelMvvm(getIt(), getIt()));

  // TODO Viper:
  getIt.registerLazySingleton<WeatherInteractorViper>(() => WeatherInteractorViperImpl());
}
