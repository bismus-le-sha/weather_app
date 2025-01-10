import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/service/periodic_weather_handler/periodic_weather_handler.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/params/weater_params.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final PeriodicWeatherUpdater periodicWeatherUpdater;
  bool _isAutoUpdating = false;

  WeatherBloc(this.getCurrentWeather, this.periodicWeatherUpdater)
      : super(WeatherInitial()) {
    on<WeatherLoad>(
      _onCityChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<StartAutoUpdate>(_onStartAutoUpdate);
    on<StopAutoUpdate>(_onStopAutoUpdate);
  }

  Future<void> _onCityChanged(
      WeatherLoad event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final result =
        await getCurrentWeather(WeatherParams(cityName: event.cityName));
    result.fold(
      (failure) => emit(WeatherLoadFailure(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> _onStartAutoUpdate(
      StartAutoUpdate event, Emitter<WeatherState> emit) async {
    if (_isAutoUpdating) return;
    _isAutoUpdating = true;

    await emit.forEach<Either<Failure, WeatherEntity>>(
      periodicWeatherUpdater.start(event.cityName, Duration(hours: 1)),
      onData: (result) {
        return result.fold(
          (failure) => WeatherLoadFailure(failure.message),
          (weather) => WeatherLoaded(weather),
        );
      },
      onError: (error, stackTrace) {
        return WeatherLoadFailure('Error during auto-update');
      },
    );
  }

  void _onStopAutoUpdate(StopAutoUpdate event, Emitter<WeatherState> emit) {
    periodicWeatherUpdater.stop();
    _isAutoUpdating = false;

    if (state is WeatherAutoUpdating) {
      emit(WeatherLoaded((state as WeatherAutoUpdating).weather));
    } else {
      emit(WeatherInitial());
    }
  }

  static EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    sl<Talker>().handle(error, stackTrace);
  }
}
