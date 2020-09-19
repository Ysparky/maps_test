import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'user_location_event.dart';
part 'user_location_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState> {
  UserLocationBloc() : super(UserLocationState());

  StreamSubscription<Geolocator.Position> _positionSubscription;

  void startTracking() {
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: Geolocator.LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((position) {
      LatLng userLocation = new LatLng(position.latitude, position.longitude);
      this.add(OnChangedLocation(userLocation));
    });
  }

  void endTracking() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<UserLocationState> mapEventToState(UserLocationEvent event) async* {
    if (event is OnChangedLocation) {
      yield state.copyWith(
        locationExists: true,
        location: event.location,
      );
    }
  }
}
