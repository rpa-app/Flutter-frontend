import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:bharatposters0/screens/settings-mvvm/pages/Refundpolicy.dart';
import 'package:bharatposters0/screens/settings-mvvm/pages/Terms.dart';
import 'package:bharatposters0/screens/settings-mvvm/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import 'package:stacked/stacked.dart';
import 'pages/AboutUs.dart';
import '../../global/CustomSecondaryButton.dart';
import 'pages/EULA.dart';
import '../../services/support_email.dart';
import 'pages/PrivacyPolicy.dart';

@RoutePage()
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => SettingsViewModel(),
        builder: (context, viewModel, child) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: themeData.colorScheme.background,
                  elevation: 0,
                  centerTitle: false,
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Work-Sans',
                        fontSize: 20,
                        color: themeData.colorScheme.onBackground),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      premiumDetails(viewModel),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          await LaunchEmail().launchEmail();
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('Asset/Icons/SupportIcon.svg',
                                height: 36),
                            const SizedBox(width: 16),
                            Text('Support',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Work-Sans',
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onBackground))
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PrivacyDocument()));
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('Asset/Icons/PrivateIcon.svg',
                                height: 36),
                            const SizedBox(width: 16),
                            Text('Privacy Policy',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Work-Sans',
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onBackground))
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TERMSDocument()));
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('Asset/Icons/Document.svg',
                                height: 36),
                            const SizedBox(width: 16),
                            Text('Terms and Conditions',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Work-Sans',
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onBackground))
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EULADocument()));
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('Asset/Icons/Document.svg',
                                height: 36),
                            const SizedBox(width: 16),
                            Text('Legal Agreement',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Work-Sans',
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onBackground))
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // GestureDetector(
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      REFUNDDocument()));
                        },
                        // onTap: () async {
                        //   const url =
                        //       'https://www.govmatters.in/cancellation-and-refund-policy'; // Your URL here
                        //   if (await canLaunch(url)) {
                        //     await launch(url);
                        //   } else {
                        //     throw 'Could not launch $url';
                        //   }
                        // },
                        child: Row(
                          children: [
                            SvgPicture.asset('Asset/Icons/Document.svg',
                                height: 36),
                            const SizedBox(width: 16),
                            Text('Cancellation and Refund Policy',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Work-Sans',
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onBackground))
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AboutUs()));
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('Asset/Icons/AboutUs.svg',
                                height: 36),
                            const SizedBox(width: 16),
                            Text('About Us',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Work-Sans',
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onBackground))
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          await viewModel.logOut(context);
                          // AutoRouter.of(context).replaceAll([LoginViewRoute()]);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('Asset/Icons/LogOut.svg',
                                height: 36),
                            const SizedBox(width: 16),
                            Text('Log Out',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Work-Sans',
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onBackground))
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        viewModel.userEmail ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontFamily: 'Mukta'),
                      ),
                      Text(
                        'This app is under Bharat Posters ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontFamily: 'Mukta'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      cancellation(viewModel),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget premiumDetails(SettingsViewModel viewModel) {
    ThemeData themeData = Theme.of(context);
    if (viewModel.remainingDays == null) {
      //do nothing
    } else if (viewModel.remainingDays! < 0) {
      viewModel.remainingDays = 0;
    }

    if (viewModel.remainingDays != null) {
      return Column(
        children: [
          SizedBox(
            height: 32,
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      spreadRadius: 2,
                      blurRadius: 14,
                      color: themeData.colorScheme.shadow.withAlpha(30))
                ]),
            child: Row(
              children: [
                SvgPicture.asset(
                  'Asset/SVG/PremiumCrown.svg',
                  height: 64,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.remainingDays! <= 0
                          ? 'आपका प्रीमियम समाप्त हो गया है'
                          : viewModel.remainingDays! <= 3
                              ? 'आपका प्रीमियम समाप्त होने वाला है'
                              : 'प्रीमियम एक्टिव है',
                      style: TextStyle(
                          fontFamily: 'Work-Sans',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'बचे हुए दिन: ${viewModel.remainingDays}',
                      style: TextStyle(
                          color: viewModel.remainingDays! <= 3
                              ? Colors.red
                              : Colors.black87,
                          fontFamily: 'Work-Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else
      return SizedBox();
  }

  Widget cancellation(SettingsViewModel viewModel) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(16),
                  backgroundColor: Colors.white,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LottieBuilder.asset(
                        'Asset/Lottie/alert.json',
                        height: 84,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'ऑटोपे कैंसिल करना चाहते हैं ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            fontFamily: 'Mukta',
                            height: 1.2,
                            color: Colors.black87),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'ऐसा करने पर आपको वापस रिचार्ज करना पड़ेगा पोस्टर शेयर करने के लिए',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            fontFamily: 'Mukta',
                            height: 1.2,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                  actions: [
                    PrimaryButton(
                      onTap: () => Navigator.pop(context),
                      label: 'नहीं, कैंसिल नहीं करना',
                      isEnabled: true,
                      height: 48,
                      isLoading: false,
                      color: themeData.colorScheme.primary,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomSecondaryButton(
                      showIcon: false,
                      leadingIcon: '',
                      onPressed: () async {
                        await viewModel.cancelSubscription();
                        AutoRouter.of(context).pop();
                        await successMessage();
                      },
                      buttonText: 'हाँ, कैंसिल करें',
                      buttonColor: null,
                    )
                  ],
                );
              });
        },
        child: viewModel.subscribedUser
            ? Text(
                'Cancel Subscription',
                style: TextStyle(
                    fontFamily: 'Work-Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.red),
              )
            : SizedBox());
  }

  Future<void> successMessage() async {
    ThemeData themeData = Theme.of(context);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Lottie.asset('Asset/Lottie/success-lottie.json'),
                    ),
                    Text('ऑटोपे कैंसिल कर दिया गया है',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Mukta',
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface))
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              PrimaryButton(
                isEnabled: true,
                height: 48,
                isLoading: false,
                onTap: () {
                  Navigator.pop(context);
                },
                label: 'Okay',
                color: themeData.colorScheme.primary,
              )
            ],
          );
        });
  }
}
