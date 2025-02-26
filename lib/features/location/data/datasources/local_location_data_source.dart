import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/constants/const.dart';

import '../models/location_model.dart';

abstract class LocalLocationDataSource {
  Future<void> addFavoriteLocation(LocationModel location);
  Future<List<LocationModel>> getFavoriteLocationList();
  Future<void> removeFavoriteLocation(LocationModel location);
}

class LocalLocationDataSourceImpl implements LocalLocationDataSource {
  SharedPreferences sharedPreferences;

  LocalLocationDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> addFavoriteLocation(LocationModel location) async {
    final list = await getFavoriteLocationList();
    if (!list.contains(location)) {
      list.add(location);
      await _saveLocationList(list);
    }
  }

  @override
  Future<List<LocationModel>> getFavoriteLocationList() async {
    if (sharedPreferences.containsKey(LOCATION_LIST)) {
      List<Map<String, dynamic>> locationJson = List<Map<String, dynamic>>.from(
          jsonDecode(sharedPreferences.getString(LOCATION_LIST) as String));
      List<LocationModel> locationList = locationJson
          .map((location) => LocationModel.fromJson(location))
          .toList();
      return await Future.value(locationList);
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<void> removeFavoriteLocation(LocationModel location) async {
    final list = await getFavoriteLocationList();
    list.remove(location);
    await _saveLocationList(list);
  }

  Future<void> _saveLocationList(List<LocationModel> list) async {
    final jsonString = jsonEncode(list.map((loc) => loc.toJson()).toList());
    await sharedPreferences.setString(LOCATION_LIST, jsonString);
  }
}
