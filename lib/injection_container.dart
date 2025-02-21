import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:weather_app/features/weather/data/data_sources/local_data_source.dart';

import 'config/router/router.dart';
import 'core/service/periodic_weather_handler/periodic_weather_handler.dart';
import 'core/util/network/network_info.dart';
import 'features/location/data/datasources/remote_location_data_source.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/repositories/location_repository.dart';
import 'features/location/domain/usecases/get_location.dart';
import 'features/location/presentation/bloc/location_bloc.dart';
import 'features/location/presentation/cubit/text_field_cubit.dart';
import 'features/weather/data/data_sources/remote_data_source.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/repositories/weather_repository.dart';
import 'features/weather/domain/usecases/get_current_weather.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Weather

  // Bloc
  sl.registerFactory(() => WeatherBloc(sl(), sl()));

  // Usecase
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
        weatherRemoteDataSource: sl(),
        weatherLocalDataSource: sl(),
        networkInfo: sl()),
  );

  // Datasource
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(sharedPreferences: sl()));

  //!Features - Location

  // Bloc
  sl.registerFactory(() => LocationBloc(sl()));

  //Cubit
  sl.registerFactory(() => TextFieldCubit(sl(), sl()));

  // Usecase
  sl.registerLazySingleton(() => GetLocation(sl()));

  // Repository
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(locationDataSource: sl(), networkInfo: sl()),
  );

  // Datasource
  sl.registerLazySingleton<LocationDataSource>(
      () => RemoteLocationDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<PeriodicWeatherUpdater>(
      () => PeriodicWeatherUpdaterImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<FocusNode>(() => FocusNode());
  sl.registerLazySingleton<TextEditingController>(
      () => TextEditingController());

  //! Config
  sl.registerSingleton<AppRouter>(AppRouter());

  //!Debug Talker
  sl.registerSingleton<Talker>(TalkerFlutter.init());
}
