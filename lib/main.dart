import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:weather_app/packages/domain/usecase/fetch_weather_use_case.dart';
import 'package:weather_app/presentation/mapper/domain_to_ui_mapper.dart';
import 'package:weather_app/presentation/patterns/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/patterns/bloc/weather_event.dart';
import 'package:weather_app/presentation/patterns/bloc/weather_bloc_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/presentation/patterns/mvi/weather_intent.dart';
import 'package:weather_app/presentation/patterns/mvi/weather_mvi_view.dart';
import 'package:weather_app/presentation/patterns/mvi/weather_view_model.dart';
import 'package:weather_app/presentation/patterns/mvp/weather_view_mvp.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_mvu_view.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_notifier.dart';
import 'package:weather_app/presentation/patterns/mvu/weather_update.dart';
import 'package:weather_app/presentation/patterns/mvvm/weather_view_model_mvvm.dart';
import 'package:weather_app/presentation/patterns/mvvm/weather_view_mvvm.dart';
import 'package:weather_app/presentation/patterns/redux/weather_action_redux.dart';
import 'package:weather_app/presentation/patterns/redux/weather_middleware_redux.dart';
import 'package:weather_app/presentation/patterns/redux/weather_page_redux.dart';
import 'package:weather_app/presentation/patterns/redux/weather_reducer_redux.dart';
import 'package:weather_app/presentation/patterns/redux/weather_state_redux.dart';
import 'package:weather_app/presentation/patterns/viper/weather_page_viper.dart';

import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  setupLocator();
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<WeatherState> store;

  const MyApp(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: StoreProvider is important for Redux only
    return StoreProvider<WeatherState>(
      store: store,
      child: MaterialApp(
          onGenerateTitle: (context) =>
            AppLocalizations.of(context)!.weatherTitle,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(_localeEn),
          ],
          // TODO BloC:
          // home: BlocProvider(
          //   create: (_) =>
          //     getIt<WeatherBloc>()..add(GetWeatherEvent()),
          //   child: WeatherBlocView() // WeatherPage(),
          // ),

          // TODO MVU:
          // home: ChangeNotifierProvider(
          //   create: (_) => WeatherNotifier(
          //     getIt<FetchWeatherUseCase>(),
          //     getIt<DomainToUiMapper>(),
          //   ),
          //   child: const WeatherMvuView(),
          // )

          // TODO MVI:
          // home: ChangeNotifierProvider(
          //   create: (_) => getIt<WeatherViewModel>()..dispatch(LoadWeather()),
          //   child: const WeatherMviView(),
          // ),

          // TODO MVP:
          // home: WeatherPageMvp(),

          // TODO MVVM:
          // home: ChangeNotifierProvider(
          //   create: (_) => getIt<WeatherViewModelMvvm>()..fetchWeather(),
          //   child: const WeatherViewMvvm(),
          // )

          // TODO Redux:
          home: WeatherPageRedux()

          // TODO Viper:
          // home: WeatherPageViper(),
      )
    )
      ;
  }

  static const String _localeEn = 'en';
}
