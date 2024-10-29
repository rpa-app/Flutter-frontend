// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' as _i13;
import 'package:flutter/widgets.dart';
// import 'package:political_poster/screens/edit-profile-mvvm/edit_profile_view.dart'
// as _i1;
// import 'package:political_poster/screens/home-mvvm/home_view.dart' as _i2;
import 'package:bharatposters0/screens/login/loginview.dart' as _i3;
import 'package:bharatposters0/screens/notification-view/notification_view.dart'
    as _i4;
import 'package:bharatposters0/screens/onboarding/onboardingview.dart' as _i5;
// import 'package:political_poster/screens/party-list/party_list_view.dart'
//     as _i6;
// import 'package:political_poster/screens/payment-init-mvvm/payment_init_view.dart'
//     as _i7;
// import 'package:political_poster/screens/premium-screen-mvvm/phonepe_premiumview.dart'
//     as _i8;

// import 'package:political_poster/screens/premium-screen-mvvm/premium_view.dart'
//     as _i8;
// import 'package:political_poster/screens/profile-mvvm/profile_view.dart' as _i9;
// import 'package:political_poster/screens/settings-mvvm/settings_view.dart'
//     as _i10;
// import 'package:political_poster/screens/upi-mvvm/upi-view.dart' as _i11;
// import 'package:political_poster/screens/Dashboard/dashboard-view.dart' as _i14;

abstract class $AutoRouter extends _i12.RootStackRouter {
  $AutoRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    // EditProfileViewRoute.name: (routeData) {
    //   final args = routeData.argsAs<EditProfileViewRouteArgs>();
    //   return _i12.AutoRoutePage<dynamic>(
    //     routeData: routeData,
    //     child: _i1.EditProfileView(
    //       key: args.key,
    //       onDetailsSaved: args.onDetailsSaved,
    //     ),
    //   );
    // },
    // HomeViewRoute.name: (routeData) {
    //   return _i12.AutoRoutePage<dynamic>(
    //     routeData: routeData,
    //     child: const _i2.HomeView(),
    //   );
    // },
    LoginViewRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LoginView(),
      );
    },
    NotificationViewRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.NotificationView(),
      );
    },
    OnboardingDetailsViewRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.OnboardingDetailsView(),
      );
    },
    // DashboardViewRoute.name: (routeData) {
    //   return _i12.AutoRoutePage<dynamic>(
    //     routeData: routeData,
    //     child: const _i14.DashboardView(),
    //   );
    // },
    // PartyListViewRoute.name: (routeData) {
    //   return _i12.AutoRoutePage<dynamic>(
    //     routeData: routeData,
    //     child: const _i6.PartyListView(),
    //   );
    // },
    // PaymentInitViewRoute.name: (routeData) {
    //   final args = routeData.argsAs<PaymentInitViewRouteArgs>();
    //   return _i12.AutoRoutePage<dynamic>(
    //     routeData: routeData,
    //     child: _i7.PaymentInitView(
    //       key: args.key,
    //       amount: args.amount,
    //       duration: args.duration,
    //       targetApp: args.targetApp,
    //       isSubscriptionUser: args.isSubscriptionUser,
    //     ),
    //   );
    // },
    // PremiumViewRoute.name: (routeData) {
    //   final args = routeData.argsAs<PremiumViewRouteArgs>();
    //   return _i12.AutoRoutePage<dynamic>(
    //     routeData: routeData,
    //     child: _i8.PremiumView(
    //       key: args.key,
    //       imageUrl: args.imageUrl,
    //       isTestUser: args.isTestUser,
    //     ),
    //   );
    // },
    // ProfileViewRoute.name: (routeData) {
    //   final args = routeData.argsAs<ProfileViewRouteArgs>();
    //   return _i12.AutoRoutePage<dynamic>(
    //     routeData: routeData,
    //     child: _i9.ProfileView(
    //       key: args.key,
    //       onProfileDetailsChange: args.onProfileDetailsChange,
    //     ),
    //   );
    // },
    // SettingsViewRoute.name: (routeData) {
    //   return _i12.AutoRoutePage<dynamic>(
    //     routeData: routeData,
    //     child: const _i10.SettingsView(),
    //   );
    // },
    // UPIViewRoute.name: (routeData) {
    //   final args = routeData.argsAs<UPIViewRouteArgs>();
    //   return _i12.AutoRoutePage<dynamic>(
    //     routeData: routeData,
    //     child: _i11.UPIView(
    //       key: args.key,
    //       duration: args.duration,
    //       amount: args.amount,
    //       packageId: args.packageId,
    //     ),
    //   );
    // },
  };
}

/// generated route for
/// [_i1.EditProfileView]
class EditProfileViewRoute
    extends _i12.PageRouteInfo<EditProfileViewRouteArgs> {
  EditProfileViewRoute({
    _i13.Key? key,
    void Function()? onDetailsSaved,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          EditProfileViewRoute.name,
          args: EditProfileViewRouteArgs(
            key: key,
            onDetailsSaved: onDetailsSaved!,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileViewRoute';

  static const _i12.PageInfo<EditProfileViewRouteArgs> page =
      _i12.PageInfo<EditProfileViewRouteArgs>(name);
}

class EditProfileViewRouteArgs {
  const EditProfileViewRouteArgs({
    this.key,
    required this.onDetailsSaved,
  });

  final _i13.Key? key;

  final void Function() onDetailsSaved;

  @override
  String toString() {
    return 'EditProfileViewRouteArgs{key: $key, onDetailsSaved: $onDetailsSaved}';
  }
}

/// generated route for
/// [_i2.HomeView]
class HomeViewRoute extends _i12.PageRouteInfo<void> {
  const HomeViewRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginView]
class LoginViewRoute extends _i12.PageRouteInfo<void> {
  const LoginViewRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoginViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.NotificationView]
class NotificationViewRoute extends _i12.PageRouteInfo<void> {
  const NotificationViewRoute({List<_i12.PageRouteInfo>? children})
      : super(
          NotificationViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationViewRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i5.OnboardingDetailsView]
class OnboardingDetailsViewRoute extends _i12.PageRouteInfo<void> {
  const OnboardingDetailsViewRoute({List<_i12.PageRouteInfo>? children})
      : super(
          OnboardingDetailsViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingDetailsViewRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

// /// generated route for
// /// [_i14.DashboardView]
// class DashboardViewRoute extends _i12.PageRouteInfo<void> {
//   const DashboardViewRoute({List<_i12.PageRouteInfo>? children})
//       : super(
//           DashboardViewRoute.name,
//           initialChildren: children,
//         );

//   static const String name = 'OnboardingDetailsViewRoute';

//   static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
// }

/// generated route for
/// [_i6.PartyListView]
class PartyListViewRoute extends _i12.PageRouteInfo<void> {
  const PartyListViewRoute({List<_i12.PageRouteInfo>? children})
      : super(
          PartyListViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'PartyListViewRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PaymentInitView]
class PaymentInitViewRoute
    extends _i12.PageRouteInfo<PaymentInitViewRouteArgs> {
  PaymentInitViewRoute({
    _i13.Key? key,
    required int amount,
    required String duration,
    required String? targetApp,
    required bool isSubscriptionUser,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          PaymentInitViewRoute.name,
          args: PaymentInitViewRouteArgs(
            key: key,
            amount: amount,
            duration: duration,
            targetApp: targetApp,
            isSubscriptionUser: isSubscriptionUser,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentInitViewRoute';

  static const _i12.PageInfo<PaymentInitViewRouteArgs> page =
      _i12.PageInfo<PaymentInitViewRouteArgs>(name);
}

class PaymentInitViewRouteArgs {
  const PaymentInitViewRouteArgs({
    this.key,
    required this.amount,
    required this.duration,
    required this.targetApp,
    required this.isSubscriptionUser,
  });

  final _i13.Key? key;

  final int amount;

  final String duration;

  final String? targetApp;

  final bool isSubscriptionUser;

  @override
  String toString() {
    return 'PaymentInitViewRouteArgs{key: $key, amount: $amount, duration: $duration, targetApp: $targetApp, isSubscriptionUser: $isSubscriptionUser}';
  }
}

/// generated route for
/// [_i8.PremiumView]
class PremiumViewRoute extends _i12.PageRouteInfo<PremiumViewRouteArgs> {
  PremiumViewRoute({
    _i13.Key? key,
    required String imageUrl,
    bool isTestUser = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          PremiumViewRoute.name,
          args: PremiumViewRouteArgs(
            key: key,
            imageUrl: imageUrl,
            isTestUser: isTestUser,
          ),
          initialChildren: children,
        );

  static const String name = 'PremiumViewRoute';

  static const _i12.PageInfo<PremiumViewRouteArgs> page =
      _i12.PageInfo<PremiumViewRouteArgs>(name);
}

class PremiumViewRouteArgs {
  const PremiumViewRouteArgs({
    this.key,
    required this.imageUrl,
    this.isTestUser = false,
  });

  final _i13.Key? key;

  final String imageUrl;

  final bool isTestUser;

  @override
  String toString() {
    return 'PremiumViewRouteArgs{key: $key, imageUrl: $imageUrl, isTestUser: $isTestUser}';
  }
}

/// generated route for
/// [_i9.ProfileView]
class ProfileViewRoute extends _i12.PageRouteInfo<ProfileViewRouteArgs> {
  ProfileViewRoute({
    _i13.Key? key,
    required void Function() onProfileDetailsChange,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ProfileViewRoute.name,
          args: ProfileViewRouteArgs(
            key: key,
            onProfileDetailsChange: onProfileDetailsChange,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileViewRoute';

  static const _i12.PageInfo<ProfileViewRouteArgs> page =
      _i12.PageInfo<ProfileViewRouteArgs>(name);
}

class ProfileViewRouteArgs {
  const ProfileViewRouteArgs({
    this.key,
    required this.onProfileDetailsChange,
  });

  final _i13.Key? key;

  final void Function() onProfileDetailsChange;

  @override
  String toString() {
    return 'ProfileViewRouteArgs{key: $key, onProfileDetailsChange: $onProfileDetailsChange}';
  }
}

/// generated route for
/// [_i10.SettingsView]
class SettingsViewRoute extends _i12.PageRouteInfo<void> {
  const SettingsViewRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SettingsViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsViewRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.UPIView]
class UPIViewRoute extends _i12.PageRouteInfo<UPIViewRouteArgs> {
  UPIViewRoute({
    _i13.Key? key,
    required String duration,
    required int amount,
    required String packageId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          UPIViewRoute.name,
          args: UPIViewRouteArgs(
            key: key,
            duration: duration,
            amount: amount,
            packageId: packageId,
          ),
          initialChildren: children,
        );

  static const String name = 'UPIViewRoute';

  static const _i12.PageInfo<UPIViewRouteArgs> page =
      _i12.PageInfo<UPIViewRouteArgs>(name);
}

class UPIViewRouteArgs {
  const UPIViewRouteArgs(
      {this.key,
      required this.duration,
      required this.amount,
      required this.packageId});

  final _i13.Key? key;

  final String duration;
  final String packageId;

  final int amount;

  @override
  String toString() {
    return 'UPIViewRouteArgs{key: $key, duration: $duration, amount: $amount ,packageid: $packageId}';
  }
}
