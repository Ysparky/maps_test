part of 'user_location_bloc.dart';

@immutable
abstract class UserLocationEvent {}

class OnChangedLocation extends UserLocationEvent {
  final LatLng location;
  OnChangedLocation(this.location);
}
