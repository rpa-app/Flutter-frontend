import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/route/route.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../utils/Singletons/prefs_singleton.dart';

@AutoRouterConfig(replaceInRouteName: '')
class AutoRouter extends $AutoRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/login',
          page: LoginViewRoute.page,
          initial: true,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          path: '/notification',
          page: NotificationViewRoute.page,
        ),
        // AutoRoute(
        //   path: '/dasboard',
        //   page: DashboardViewRoute.page,
        // ),
        // AutoRoute(
        //   path: '/onboarding',
        //   page: OnboardingDetailsViewRoute.page,
        // ),
        // AutoRoute(
        //   path: '/partyList',
        //   page: PartyListViewRoute.page,
        // ),
        // AutoRoute(
        //   path: '/home',
        //   page: HomeViewRoute.page,
        // ),
        // AutoRoute(
        //   path: '/profile',
        //   page: ProfileViewRoute.page,
        // ),
        // AutoRoute(
        //   path: '/editProfile',
        //   page: EditProfileViewRoute.page,
        // ),
        // AutoRoute(
        //   path: '/settings',
        //   page: SettingsViewRoute.page,
        // ),
        // AutoRoute(
        //   path: '/premium',
        //   page: PremiumViewRoute.page,
        // ),
        // AutoRoute(
        //   path: '/customUPI',
        //   page: UPIViewRoute.page,
        // ),
        // AutoRoute(
        //   path: '/paymentInit',
        //   page: PaymentInitViewRoute.page,
        // ),
      ];

  static of(BuildContext context) {}
}

//
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // TODO: implement onNavigation

    bool? isOnboarded = Prefs.instance.getBool('isOnboarded');
    String? selectedCategory = Prefs.instance.getString('CategorySelected');
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    final String? token = prefs.getString('token');
    //user is not logged in
    if (userId == null && token == null) {
      resolver.next(true);
    } else if (isOnboarded == false) {
      resolver.redirect(OnboardingDetailsViewRoute());
    } else if (isOnboarded == true && selectedCategory != null) {
      resolver.redirect(HomeViewRoute());
    } else if (isOnboarded == true && selectedCategory == null) {
      resolver.redirect(PartyListViewRoute());
    }
  }
}
