import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/screens/onboarding/onboardingview.dart';
import 'package:bharatposters0/services/permissionservice.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

class NotificationViewModel extends BaseViewModel {
  Future<void> askNotificationPermission(context) async {
    await PermissionAccess().requestNotificationsPermissions();
    await PermissionAccess().requestStoragePermission();
//       Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) => OnboardingDetailsView(token: '',),
// ));

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const OnboardingDetailsView()));
    // AutoRouter.of(context).replace(OnboardingDetailsViewRoute());
  }
}
