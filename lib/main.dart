import 'package:bharatposters0/route/route.dart';
import 'package:bharatposters0/screens/Login/Introductionscreen.dart';
import 'package:bharatposters0/screens/Login/loginview.dart';
import 'package:bharatposters0/services/notificationservice.dart';
import 'package:bharatposters0/theme/theme_setup.dart';
import 'package:bharatposters0/utils/Singletons/prefs_singleton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Import your onboarding screen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.initialise();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize();
  // await PushNotificationService().setupInteractedMessage();
  await Prefs.init();
  // await FacebookAppEvents().logCompletedRegistration();

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // String? token = await messaging.getToken();
  // print("FCM Token: $token");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      themes: getThemes(),
      builder: (context, regularTheme, darkTheme, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: regularTheme,
          darkTheme: darkTheme,
          home: FutureBuilder<bool>(
            future: _checkIfAuthenticated(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data == true) {
                // User is authenticated, navigate to LoginView
                return LoginView(); // Or replace this with your actual route
              } else {
                // User is not authenticated, navigate to OnboardingScreen
                return OnboardingScreen(); // This is your onboarding screen
              }
            },
          ),
        );
      },
    );
  }

  Future<bool> _checkIfAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuthenticated') ?? false;
  }
}
