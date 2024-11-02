import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/global/CustomSecondaryLoader.dart';
import 'package:bharatposters0/route/route.gr.dart';
import 'package:bharatposters0/screens/Notification-view/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {

  Future<void> signInWithGoogle(BuildContext context) async {

     showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissal by tapping outside
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Transparent background
        child: CustomLoader(), // Use the loading widget
      );
    },
  );
    final GoogleSignIn googleSignIn =
        GoogleSignIn(scopes: ['email', 'profile']);
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    Navigator.of(context).pop();
    if (googleSignInAccount == null) {
      print('Sign-in aborted by user or failed.');
      return;
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final idToken = googleSignInAuthentication.accessToken;
    print('ID Token: $idToken');

    // Call the login endpoint with the token
    final loginSuccess = await loginUserWithGoogle(idToken!);

    if (loginSuccess) {
      final prefs = await SharedPreferences.getInstance();
      final appUserId = prefs.getString('userId');
      print('appUserId: $appUserId');

      await saveAuthentication(true);

      if (appUserId != null) {
        // Make config call after successful authentication
        await configCall();

        // Navigate to NotificationView
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NotificationView()));
      } else {
        print('User ID is missing');
      }
    } else {
      print('Login failed');
    }
  }

  Future<void> saveAuthentication(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', isAuthenticated);
  }

  Future<bool> loginUserWithGoogle(String idToken) async {
    final url = Uri.parse(
        'https://bharatposters.rpaventuresllc.com/signInUser?access_token=$idToken');
    final headers = <String, String>{
      'Content-Type': 'application/json',
      "package-name": "com.bharat.posters"
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(response.body);

        final token = responseData['token'];
        final userId = responseData['appUserId'];
        await saveUserId(userId.toString());
        await saveToken(token);

        return true;
      } else {
        print('Login failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print("Saved token: $token");
  }

  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    print("Saved userId: $userId");
  }

  Future<void> configCall() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final String userId = prefs.getString('userId') ?? "";
    print("token for config:$token");

    final url =
        Uri.parse('https://bharatposters.rpaventuresllc.com/getStatePartyAgg');
    final headers = {
      'token': token,
      'appUserId': userId,
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print('Config call successful: ${response.body}');

        // Save the response in SharedPreferences
        await prefs.setString('configResponse', response.body);
        print('Config response saved in SharedPreferences');
      } else {
        print('Config call failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during config call: $e');
    }
  }

  Future<void> signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    AutoRouter.of(context).replace(const LoginViewRoute());
  }
}
