import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_test/bloc/Map/map_bloc.dart';
import 'package:maps_test/bloc/UserLocation/user_location_bloc.dart';
import 'package:maps_test/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    context.bloc<UserLocationBloc>().startTracking();
    super.initState();
  }

  @override
  void dispose() {
    context.bloc<UserLocationBloc>().endTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<UserLocationBloc, UserLocationState>(
            builder: (context, state) => createMap(state),
          ),
          SearchBar(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnMyLocation(),
          BtnFollowLocation(),
          BtnMyRoute(),
        ],
      ),
    );
  }

  Widget createMap(UserLocationState state) {
    if (!state.locationExists) return Text('Locating...');

    context.bloc<MapBloc>().add(OnLocationUpdated(state.location));

    final cameraPosition = new CameraPosition(
      target: state.location,
      zoom: 15,
    );
    LatLng centerPoint;

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, _) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (controller) =>
              context.bloc<MapBloc>().initMap(controller),
          polylines: context.bloc<MapBloc>().state.polylines.values.toSet(),
          onCameraMove: (position) {
            centerPoint = position.target;
          },
          onCameraIdle: () {
            context.bloc<MapBloc>().add(OnMapMoved(centerPoint));
          },
          onTap: (argument) {
            print(argument.toString());
          },
        );
      },
    );
  }
}
