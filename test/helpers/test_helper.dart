import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/service/periodic_weather_handler/periodic_weather_handler.dart';
import 'package:weather_app/core/util/network/network_info.dart';
import 'package:weather_app/features/location/data/datasources/local_location_data_source.dart';
import 'package:weather_app/features/location/data/datasources/remote_location_data_source.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';
import 'package:weather_app/features/location/domain/usecases/add_favorite_location.dart';
import 'package:weather_app/features/location/domain/usecases/get_favorite_location_list.dart';
import 'package:weather_app/features/location/domain/usecases/get_location_list.dart';
import 'package:weather_app/features/location/domain/usecases/remove_favorite_location.dart';
import 'package:weather_app/features/weather/data/data_sources/local_data_source.dart';
import 'package:weather_app/features/weather/data/data_sources/remote_data_source.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';

@GenerateMocks(
  [
    //weather
    WeatherBloc,
    WeatherRepository,
    WeatherRemoteDataSource,
    WeatherLocalDataSource,
    GetCurrentWeather,
    PeriodicWeatherUpdater,
    SharedPreferences,
    NetworkInfo,
    http.Client,
    //internet_connection_checker_plus
    InternetConnection,
    //location
    LocalLocationDataSource,
    RemoteLocationDataSource,
    LocationRepository,
    GetLocationList,
    AddFavoriteLocation,
    RemoveFavoriteLocation,
    GetFavoriteLocationList,
  ],
)
void main() {}
