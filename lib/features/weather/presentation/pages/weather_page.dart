import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_display.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_failure_display.dart';

import '../../../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

@RoutePage()
class WeatherPage extends StatefulWidget {
  final String cityName;
  const WeatherPage({super.key, required this.cityName});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherLoad(widget.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WeatherBloc>()..add(StartAutoUpdate(widget.cityName)),
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
