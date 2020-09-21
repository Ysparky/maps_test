import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult {
  final bool isCanceled;
  final bool isManual;
  final LatLng position;
  final String targetName;
  final String description;

  SearchResult({
    this.isCanceled,
    this.isManual,
    this.position,
    this.targetName,
    this.description,
  });
}
