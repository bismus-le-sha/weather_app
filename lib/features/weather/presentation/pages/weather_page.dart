import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_display.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_failure_display.dart';

import '../../../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void dispose() {
    context.read<WeatherBloc>().add(StopAutoUpdate());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WeatherBloc>()..add(StartAutoUpdate('Омск')),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return WeatherLoadingDisplay();
          } else if (state is WeatherLoaded) {
            return WeatherDisplay(weather: state.weather);
          } else if (state is WeatherLoadFailure) {
            return WeatherFailureDisplay(
              failureMessage: state.message,
            );
          } else {
            return WeatherLoadingDisplay();
          }
        },
      ),
    );
  }
}
