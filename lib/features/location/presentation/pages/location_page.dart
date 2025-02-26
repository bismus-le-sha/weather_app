// location_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/presentation/bloc/favorite_locations/favorite_location_bloc.dart';
import '../../../../injection_container.dart';
import '../widgets/favorite_location/favorite_location_list.dart';
import '../widgets/location/location_widgets.dart';

@RoutePage()
class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => sl<FavoriteLocationBloc>()..add(GetFavorite()),
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            LocationTitle(),
            FavoriteLocationList(screenWidth, screenHeight),
            OverlayWithTextFieldFocus(),
            LocationInputField(screenWidth, screenHeight),
          ],
        )),
      ),
    );
  }
}
