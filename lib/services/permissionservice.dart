import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionAccess {
  Future<bool> requestStoragePermission() async {
    bool isPermissionGranted = false;

    // Assume the minimum SDK version requiring permission is 23 (Android 6.0/Marshmallow)
    final storageStatus = await Permission.storage.request();

    if (storageStatus.isGranted) {
      isPermissionGranted = true;
    } else if (storageStatus.isPermanentlyDenied ||
        storageStatus.isDenied ||
        storageStatus.isRestricted) {
      isPermissionGranted = false;
    }

    return isPermissionGranted;
  }

  Future<void> requestNotificationsPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    PermissionStatus permissionStatus = await Permission.notification.status;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (permissionStatus.isDenied) {
      sharedPreferences.setBool('NotificationPermission', false);
    } else if (permissionStatus.isGranted) {
      sharedPreferences.setBool('NotificationPermission', true);
    }
  }
}
