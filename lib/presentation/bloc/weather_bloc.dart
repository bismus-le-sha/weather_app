import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/get_current_weather.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      _onCityChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onCityChanged(
      OnCityChanged event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final result = await _getCurrentWeatherUseCase.execute(event.cityName);

    result.fold(
      (failure) => emit(WeatherLoadFailue(failure.message)),
      (data) => emit(WeatherLoaded(data)),
    );
  }

  static EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
