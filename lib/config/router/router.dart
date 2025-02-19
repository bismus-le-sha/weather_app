import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../features/location/presentation/pages/city_page.dart';
import '../../features/weather/presentation/pages/weather_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CityRoute.page, path: '/city', initial: true),
        AutoRoute(page: WeatherRoute.page, path: '/weather/:cityName'),
      ];
}
