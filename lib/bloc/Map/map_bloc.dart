import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_test/utils/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _mapController;

  Polyline _myRoute = Polyline(
    polylineId: PolylineId('my_route'),
    width: 4,
    color: Colors.black87,
  );

  Polyline _destinationRoute = Polyline(
    polylineId: PolylineId('destination_route'),
    width: 4,
    color: Colors.green,
  );

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
    } else if (event is OnLocationUpdated) {
      yield* _onLocationUpdated(event);
    } else if (event is OnToggleTrackingRoute) {
      yield* _onToggleTrackingRoute(event);
    } else if (event is OnFollowLocation) {
      if (!state.followLocation) {
        this.moveCamera(this._myRoute.points.last);
      }
      yield state.copyWith(followLocation: !state.followLocation);
    } else if (event is OnMapMoved) {
      print(event.centerPoint);
      yield state.copyWith(centralPoint: event.centerPoint);
    } else if (event is OnDrawDestinationRoute) {
      yield* _onDrawDestinationRoute(event);
    }
  }

  Stream<MapState> _onLocationUpdated(OnLocationUpdated event) async* {
    if (state.followLocation) {
      this.moveCamera(event.location);
    }

    final points = [..._myRoute.points, event.location];
    this._myRoute = this._myRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;
    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapState> _onToggleTrackingRoute(OnToggleTrackingRoute event) async* {
    if (!state.drawTracking) {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.black87);
    } else {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;
    yield state.copyWith(
      drawTracking: !state.drawTracking,
      polylines: currentPolylines,
    );
  }

  Stream<MapState> _onDrawDestinationRoute(
      OnDrawDestinationRoute event) async* {
    this._destinationRoute = this._destinationRoute.copyWith(
          pointsParam: event.coordPoints,
        );

    final currentPolylines = state.polylines;
    currentPolylines['destination_route'] = this._destinationRoute;

    yield state.copyWith(
      polylines: currentPolylines,
    );
  }
}
