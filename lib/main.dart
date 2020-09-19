import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_test/bloc/Map/map_bloc.dart';
import 'package:maps_test/bloc/UserLocation/user_location_bloc.dart';
import 'package:maps_test/pages/map_page.dart';
import 'package:maps_test/pages/request_access_page.dart';
import 'package:maps_test/pages/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserLocationBloc()),
        BlocProvider(create: (_) => MapBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: '/splash',
        routes: {
          '/map': (context) => MapPage(),
          '/splash': (context) => SplashPage(),
          '/request_access': (context) => RequestAccessPage(),
        },
      ),
    );
  }
}
