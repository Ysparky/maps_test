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

class OnMapMoved extends MapEvent {
  final LatLng centerPoint;

  OnMapMoved(this.centerPoint);
}
