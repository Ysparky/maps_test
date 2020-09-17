import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_test/pages/map_page.dart';

import 'package:maps_test/utils/helper.dart';

import 'package:maps_test/pages/request_access_page.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:maps_test/pages/map_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await isLocationServiceEnabled()) {
        Navigator.pushReplacementNamed(context, '/splash');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLocationAndGPS(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }
        },
      ),
    );
  }

  Future checkLocationAndGPS() async {
    // await Future.delayed(Duration(milliseconds: 200));
    final permissionGranted = await Permission.location.isGranted;
    final locationEnabled = await isLocationServiceEnabled();

    if (permissionGranted && locationEnabled) {
      Navigator.pushReplacement(context, fadeInAnimation(context, MapPage()));
    } else if (!permissionGranted) {
      Navigator.pushReplacement(
          context, fadeInAnimation(context, RequestAccessPage()));
    } else if (!locationEnabled) {
      return 'Active el GPS';
    }
  }
}
