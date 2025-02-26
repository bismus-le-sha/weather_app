import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/url_handler.dart';
import '../../../../core/error/exceptions.dart';
import '../models/location_model.dart';

abstract class RemoteLocationDataSource {
  Future<List<LocationModel>> getLocationList(String query);
}

class RemoteLocationDataSourceImpl extends RemoteLocationDataSource {
  final http.Client client;
  RemoteLocationDataSourceImpl({required this.client});

  @override
  Future<List<LocationModel>> getLocationList(String query) async {
    final response = await client.get(Uri.parse(Urls.locationByName(query)));

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = jsonDecode(decodedBody);
      return jsonData.map((e) => LocationModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
