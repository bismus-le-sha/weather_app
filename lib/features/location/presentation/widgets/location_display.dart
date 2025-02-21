import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/presentation/cubit/text_field_cubit.dart';

import '../../../../config/router/router.dart';
import '../../domain/entities/location.dart';
import '../bloc/location_bloc.dart';
import 'location_search_bar.dart';

class LocationDisplay extends StatelessWidget {
  const LocationDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      builder: (context, state) {
        final cubit = context.read<TextFieldCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const LocationSearchBar(),
            const SizedBox(height: 10),
            if (cubit.focusNode.hasFocus) _buildLocationContent(context),
          ],
        );
      },
    );
  }

  Widget _buildLocationContent(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return _buildLoadingIndicator();
        } else if (state is LocationLoaded) {
          return _buildLocationList(state.locationList);
        } else if (state is LocationFailure) {
          return _buildErrorMessage(state.message);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildLocationList(List<LocationEntity> locations) {
    if (locations.isEmpty) {
      return _buildNoResultsMessage();
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return _buildLocationTile(context, locations[index]);
        },
      ),
    );
  }

  Widget _buildLocationTile(BuildContext context, LocationEntity location) {
    return ListTile(
      title: Text(location.city),
      subtitle: Text('${location.region}, ${location.countryName}'),
      onTap: () => _navigateToWeather(context, location.city),
    );
  }

  Widget _buildNoResultsMessage() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(child: Text('No results found')),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child:
            Text('Error: $message', style: const TextStyle(color: Colors.red)),
      ),
    );
  }

  void _navigateToWeather(BuildContext context, String city) {
    context.pushRoute(WeatherRoute(cityName: city));
  }
}
