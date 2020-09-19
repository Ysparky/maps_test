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
      body: BlocBuilder<UserLocationBloc, UserLocationState>(
        builder: (context, state) => createMap(state),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnMyLocation(),
        ],
      ),
    );
  }

  Widget createMap(UserLocationState state) {
    if (!state.locationExists) return Text('Locating...');

    final cameraPosition = new CameraPosition(
      target: state.location,
      zoom: 15,
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) => context.bloc<MapBloc>().initMap(controller),
    );
  }
}
