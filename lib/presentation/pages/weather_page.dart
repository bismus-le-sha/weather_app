import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/widgets/weather_display.dart';

import '../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = sl<WeatherBloc>();
    return BlocProvider(create: (_) {
      bloc.add(WeatherLoad('Омск'));
      return bloc;
    }, child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherEmpty) {
        return const Center(child: Text('Please enter a city name'));
      } else if (state is WeatherLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is WeatherLoaded) {
        return WeatherDisplay(
          weather: state.weather,
        );
        // return Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(weather.cityName),
        //     Text(weather.localtime),
        //     Text('${weather.temperature}°C'),
        //     Text('${weather.feelsLike}°C'),
        //     Image.network(weather.conditionIconUrl),
        //     Text(weather.conditionCode.toString()),
        //     Text(weather.conditionText),
        //     Text('${weather.windSpeed} m/s'),
        //   ],
        // );
      } else if (state is WeatherLoadFailure) {
        return Center(child: Text(state.message));
      } else {
        return const Center(child: Text('Something went wrong'));
      }
    }));
  }
}
