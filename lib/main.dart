import 'package:flutter/material.dart';
import 'package:maps_test/pages/map_page.dart';
import 'package:maps_test/pages/request_access_page.dart';
import 'package:maps_test/pages/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/splash',
      routes: {
        '/map': (context) => MapPage(),
        '/splash': (context) => SplashPage(),
        '/request_access': (context) => RequestAccessPage(),
      },
    );
  }
}
