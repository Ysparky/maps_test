import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_test/utils/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _mapController;

  void initMap(GoogleMapController controller) {
    if (!state.isMapReady) {
      this._mapController = controller;
      this._mapController.setMapStyle(json.encode(uberMapTheme));
    }
    print('ready');
    add(OnMapLoaded());
  }

  void moveCamera(LatLng target) {
    final cameraUpdate = CameraUpdate.newLatLng(target);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnMapLoaded) {
      yield state.copyWith(isMapReady: true);
    }
  }
}
