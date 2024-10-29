// import 'package:auto_route/annotations.dart';
// import 'package:bharatposters0/screens/Notification-view/notification_viewmodel.dart';
// import 'package:bharatposters0/global/primarybutton.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// import 'package:stacked/stacked.dart';

// @RoutePage()
// class NotificationView extends StatefulWidget {
//   const NotificationView({super.key});

//   @override
//   State<NotificationView> createState() => _NotificationViewState();
// }

// class _NotificationViewState extends State<NotificationView> {
//   @override
//   Widget build(BuildContext context) {
//     ThemeData themeData = Theme.of(context);
//     return ViewModelBuilder<NotificationViewModel>.reactive(
//         viewModelBuilder: () => NotificationViewModel(),
//         builder: (context, model, child) => Scaffold(
//               body: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   LottieBuilder.asset(
//                     'Asset/Lottie/notificationBell.json',
//                     height: 160,
//                   ),
//                   SizedBox(
//                     height: 56,
//                   ),
//                   Text('Allow permissions for best\ndaily designs',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontFamily: 'Work-Sans',
//                           fontSize: 24,
//                           fontWeight: FontWeight.w800,
//                           color: themeData.colorScheme.onBackground)),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   Text('Press allow to give us proper permissions',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontFamily: 'Work-Sans',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: themeData.colorScheme.onBackground)),
//                   SizedBox(
//                     height: 24,
//                   ),
//                   Container(
//                       padding: EdgeInsets.all(16),
//                       child: PrimaryButton(
//                         label: 'Allow permissions',
//                         height: 56,
//                         isLoading: false,
//                         isEnabled: true,
//                         color: themeData.colorScheme.primary,
//                         onTap: () async {
//                           await model.askNotificationPermission(context);
//                         },
//                       )),
//                   SizedBox(
//                     height: 32,
//                   )
//                 ],
//               ),
//             ));
//   }
// }

import 'package:auto_route/annotations.dart';
import 'package:bharatposters0/screens/Notification-view/notification_viewmodel.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie Animation at the top with shadow
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: LottieBuilder.asset(
                    'Asset/Lottie/notificationBell.json',
                    height: 180,
                  ),
                ),

                // New engaging title and description text
                const SizedBox(height: 32),
                Text(
                  'Get Notified!',
                  style: themeData.textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: themeData.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Stay in the loop with the latest designs and trends. Allow notifications to make sure you never miss out!',
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.bodyText1?.copyWith(
                    color: themeData.colorScheme.onBackground,
                    fontSize: 16,
                  ),
                ),

                // Updated button with ample spacing below
                const SizedBox(height: 36),
                PrimaryButton(
                  label: 'Enable Notifications',
                  height: 56,
                  isLoading: model.isBusy,
                  isEnabled: true,
                  color: themeData.colorScheme.primary,
                  onTap: () async {
                    await model.askNotificationPermission(context);
                  },
                ),

                const SizedBox(height: 50), // Extra spacing for visual balance
              ],
            ),
          ),
        ),
      ),
    );
  }
}
