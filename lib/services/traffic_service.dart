import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_test/models/search_response.dart';
import 'package:maps_test/models/traffic_response.dart';

const _BASE_URL_DIR = 'https://api.mapbox.com/directions/v5';
const _BASE_URL_GEO = 'https://api.mapbox.com/geocoding/v5';
const _API_KEY =
    'pk.eyJ1IjoiYWxmYWxmYTI3IiwiYSI6ImNrZmFidWtqOTA3MXcyeG9nYTlnN2VocjcifQ.Y7rvXSuCyuPwLMkiHenDkQ';

class TrafficService {
  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();

  Future<DrivingResponse> getRoutePointsByOriginAndDestination(
    LatLng origin,
    LatLng destination,
  ) async {
    final coordPoints =
        '${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}';
    final _url = '$_BASE_URL_DIR/mapbox/driving/$coordPoints';

    final response = await _dio.get(_url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': _API_KEY,
      'language': 'es',
    });

    final data = DrivingResponse.fromJson(response.data);

    return data;
  }

  Future<SearchResponse> getResultsByQuery(
    String query,
    LatLng proximityPoint,
  ) async {
    final _url = '$_BASE_URL_GEO/mapbox.places/$query.json';

    try {
      final response = await _dio.get(_url, queryParameters: {
        'access_token': _API_KEY,
        'autocomplete': 'true',
        'proximity': '${proximityPoint.longitude},${proximityPoint.latitude}',
        'language': 'es',
      });

      final data = searchResponseFromJson(response.data);

      return data;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }
}
