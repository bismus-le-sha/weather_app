import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import '../../../../config/router/router.dart';
import '../bloc/location_bloc.dart';

class AsyncSearchAnchor extends StatefulWidget {
  const AsyncSearchAnchor({super.key});

  @override
  State<AsyncSearchAnchor> createState() => _AsyncSearchAnchorState();
}

class _AsyncSearchAnchorState extends State<AsyncSearchAnchor> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSearchField(context),
        const SizedBox(height: 10),
        _buildSearchResults(),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Search for a city',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
      onChanged: (query) {
        context.read<LocationBloc>().add(OnLocationChanged(query.trim()));
      },
    );
  }

  Widget _buildSearchResults() {
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
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('No results found')),
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return ListTile(
            title: Text(location.city),
            subtitle: Text('${location.region}, ${location.countryName}'),
            onTap: () => _navigateToWeather(context, location.city),
          );
        },
      ),
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
