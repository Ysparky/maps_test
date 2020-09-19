part of 'user_location_bloc.dart';

@immutable
class UserLocationState {
  final bool tracking;
  final bool locationExists;
  final LatLng location;

  UserLocationState({
    this.tracking = true,
    this.locationExists = false,
    this.location,
  });

  UserLocationState copyWith({
    bool tracking,
    bool locationExists,
    LatLng location,
  }) =>
      UserLocationState(
        location: location ?? this.location,
        locationExists: locationExists ?? this.locationExists,
        tracking: tracking ?? this.tracking,
      );
}
