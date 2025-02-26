import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/router.dart';
import '../../../data/models/location_model.dart';
import '../../../domain/entities/location.dart';
import '../../bloc/favorite_locations/favorite_location_bloc.dart';
import '../../cubit/text_field_cubit.dart';
import 'favorite_location_card.dart';

class FavoriteLocationList extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const FavoriteLocationList(this.screenWidth, this.screenHeight, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TextFieldCubit, TextFieldState, bool>(
      selector: (state) => state.hasFocus,
      builder: (context, hasFocus) {
        return AnimatedPositioned(
            top: hasFocus ? screenHeight * .07 : screenHeight * .12 + 20,
            left: 20,
            width: screenWidth * .9,
            duration: const Duration(milliseconds: 300),
            child: BlocBuilder<FavoriteLocationBloc, FavoriteLocationState>(
              builder: (context, state) {
                if (state is FavoriteLocationLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is FavoriteLocationFailure) {
                  return Center(child: Text('Error: ${state.message}'));
                }

                if (state is FavoriteLocationLoaded) {
                  return SizedBox(
                    height: screenHeight * 0.9,
                    child: ListView.builder(
                      itemCount: state.locationList.length,
                      itemBuilder: (context, index) {
                        LocationEntity location = state.locationList[index];
                        return FavoriteLocationCard(
                          screenHeight: screenHeight,
                          location: location as LocationModel,
                          onTap: () =>
                              _navigateToWeather(context, location.city),
                        );
                      },
                    ),
                  );
                }

                return Center(child: Text('No favorites found.'));
              },
            ));
      },
    );
  }
}

void _navigateToWeather(BuildContext context, String city) {
  context.pushRoute(WeatherRoute(cityName: city));
}
