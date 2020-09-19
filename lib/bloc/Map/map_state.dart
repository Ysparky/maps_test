part of 'map_bloc.dart';

@immutable
class MapState {
  final bool isMapReady;
  final bool drawTracking;
  final bool followLocation;
  final LatLng centralPoint;
  final Map<String, Polyline> polylines;

  MapState(
      {this.isMapReady = false,
      this.drawTracking = true,
      this.followLocation = false,
      this.centralPoint,
      Map<String, Polyline> polylines})
      : this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool isMapReady,
    bool drawTracking,
    bool followLocation,
    LatLng centralPoint,
    Map<String, Polyline> polylines,
  }) =>
      MapState(
        isMapReady: isMapReady ?? this.isMapReady,
        drawTracking: drawTracking ?? this.drawTracking,
        followLocation: followLocation ?? this.followLocation,
        centralPoint: centralPoint ?? this.centralPoint,
        polylines: polylines ?? this.polylines,
      );
}
