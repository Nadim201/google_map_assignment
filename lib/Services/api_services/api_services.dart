import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_map_assignment/Services/const/constans.dart';

import '../model/place_coordinate_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
   Future<PlaceCoordinateModel> placeFromCoordinate(
      double lat, double lot) async {
    Uri uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lot&key=$apiKey');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      debugPrint('Request status:${response.statusCode}');
      debugPrint('Request body:$responseBody');
      return PlaceCoordinateModel.fromJson(responseBody);
    } else {
      throw Exception('Failed to Fetch location:${response.statusCode} ');
    }
  }
}
