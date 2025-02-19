import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/presentation/bloc/location_bloc.dart';

import 'config/router/router.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'injection_container.dart' as di;

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<WeatherBloc>()),
        BlocProvider(create: (_) => di.sl<LocationBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: di.sl<AppRouter>().config(),
      ),
    );
  }
}
