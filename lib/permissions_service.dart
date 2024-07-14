import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<bool> requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }
}
