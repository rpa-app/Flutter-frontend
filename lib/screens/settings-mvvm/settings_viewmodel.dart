import 'package:bharatposters0/services/cancel_subscriptions.dart';
import 'package:bharatposters0/utils/Singletons/prefs_singleton.dart';
import 'package:bharatposters0/utils/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  //instances
  final Prefs _prefs = Prefs.instance;

  //setters and getters
  bool get subscribedUser => _prefs.getBool('isSubscribedUser') ?? false;
  set subscribedUser(value) => _prefs.setBool('isSubscribedUser', value);

  int? get remainingDays => _prefs.getInt('daysLeft');
  set remainingDays(value) => _prefs.setInt('key', value);

  String? get userEmail => FirebaseAuth.instance.currentUser?.email;
  // final Prefs _prefs = Prefs.instance;
  final Authentication _authentication = Authentication();

  Future logOut(context) async {
    await _authentication.signOut(context);
  }

  //functions for business logic
  Future cancelSubscription() async {
    String? userID = FirebaseAuth.instance.currentUser?.email;
    await CancelSubscriptions(userID: userID ?? '').cancelSubscription();
    _prefs.setBool('isSubscribedUser', false);
    notifyListeners();
  }

  // Future logOut(context) async{
  //  await Authentication.signOut(context: context);
  // }
}
