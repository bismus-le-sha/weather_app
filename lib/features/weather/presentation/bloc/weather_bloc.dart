import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/params.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;

  WeatherBloc(this.getCurrentWeather) : super(WeatherInitial()) {
    on<WeatherLoad>(
      _onCityChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onCityChanged(
      WeatherLoad event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final result =
        await getCurrentWeather(WeatherParams(cityName: event.cityName));

    result.fold(
      (failure) => emit(WeatherLoadFailure(failure.message)),
      (data) => emit(WeatherLoaded(data)),
    );
  }

  static EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
