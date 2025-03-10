import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/location_model.dart';
import '../../bloc/favorite_locations/favorite_location_bloc.dart';

class FavoriteLocationCard extends StatelessWidget {
  const FavoriteLocationCard(
      {super.key,
      required this.screenHeight,
      required this.location,
      required this.onTap});

  final double screenHeight;
  final LocationModel location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Container(
          height: screenHeight * .15,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListTile(
            leading: Icon(Icons.location_on),
            title: Text(location.city),
            subtitle: Text(location.countryName),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                BlocProvider.of<FavoriteLocationBloc>(context).add(
                  RemoveFavorite(location),
                );
              },
            ),
            onTap: onTap,
          ),
        ));
  }
}
