import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/presentation/bloc/suggested_locations/location_bloc.dart';
import 'package:weather_app/features/location/presentation/cubit/text_field_cubit.dart';

import 'config/router/router.dart';
import 'features/location/presentation/bloc/favorite_locations/favorite_location_bloc.dart';
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
        BlocProvider(create: (_) => di.sl<TextFieldCubit>()),
        BlocProvider(create: (_) => di.sl<FavoriteLocationBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: di.sl<AppRouter>().config(),
      ),
    );
  }
}
