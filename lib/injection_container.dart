import 'package:get_it/get_it.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_current_weather.dart';
import 'presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => WeatherBloc(sl()));

  // usecase
  sl.registerLazySingleton(() => GetCurrentWeatherUseCase(sl()));

  // repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: sl()),
  );

  // data source
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // external
  sl.registerLazySingleton(() => http.Client());
}
