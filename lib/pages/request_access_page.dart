import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestAccessPage extends StatefulWidget {
  @override
  _RequestAccessPageState createState() => _RequestAccessPageState();
}

class _RequestAccessPageState extends State<RequestAccessPage>
    with WidgetsBindingObserver {
  bool onPopup = false;
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
    print('======> $state');
    if (state == AppLifecycleState.resumed && !onPopup) {
      if (await Permission.location.status.isGranted) {
        Navigator.pushReplacementNamed(context, '/splash');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el GPS para el funcionamiento de la aplicación'),
            const SizedBox(height: 10),
            MaterialButton(
              child: Text(
                'Solicitar acceso',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              splashColor: Colors.transparent,
              onPressed: () async {
                onPopup = true;
                final permissionStatus = await Permission.location.request();
                print(permissionStatus);
                await handlePermissionStatus(permissionStatus);
                onPopup = false;
                print(permissionStatus);
              },
            )
          ],
        ),
      ),
    );
  }

  Future handlePermissionStatus(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, '/splash');
        break;

      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
