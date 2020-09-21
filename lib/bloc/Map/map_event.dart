part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapLoaded extends MapEvent {}

class OnLocationUpdated extends MapEvent {
  final LatLng location;

  OnLocationUpdated(this.location);
}

class OnToggleTrackingRoute extends MapEvent {}

class OnFollowLocation extends MapEvent {}

class OnDrawDestinationRoute extends MapEvent {
  final List<LatLng> coordPoints;
  final double distance;
  final double duration;

  OnDrawDestinationRoute(this.coordPoints, this.distance, this.duration);
}

class OnMapMoved extends MapEvent {
  final LatLng centerPoint;

  OnMapMoved(this.centerPoint);
}
