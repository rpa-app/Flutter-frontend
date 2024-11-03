import 'package:bharatposters0/route/route.dart';
import 'package:bharatposters0/screens/Login/Introductionscreen.dart';
import 'package:bharatposters0/screens/Login/loginview.dart';
import 'package:bharatposters0/screens/home-mvvm/home_view.dart';
import 'package:bharatposters0/screens/party-list/party_list_view.dart';
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
          home: FutureBuilder<Widget>(
            future: _checkUserState(),
           builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return snapshot.data!;
              } else {
                return Center(child: Text("Error occurred"));
              }
            },
          ),
        );
      },
    );
  }

   Future<Widget> _checkUserState() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    final String? token = prefs.getString('token');
    final String? selectedCategory = prefs.getString('CategorySelected');
    final bool isOnboarded = prefs.getBool('isOnboarded') ?? false;

    // User is not logged in
    if (userId == null && token == null) {
      return OnboardingScreen();
    } else if (!isOnboarded) {
      return OnboardingScreen();
    // } else if (isOnboarded && selectedCategory != null) {
    //   return HomeView(); // Navigate to HomeView if category is selected
    } else {
      return PartyListView(); // Navigate to PartyListView if no category is selected
    }}
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('isAuthenticated') ?? false;
  // }
}
