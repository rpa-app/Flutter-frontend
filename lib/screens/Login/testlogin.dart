import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:bharatposters0/global/searchfeild.dart';
import 'package:bharatposters0/route/route.gr.dart';
import 'package:bharatposters0/screens/Notification-view/notification_view.dart';
import 'package:bharatposters0/utils/authentication/authentication.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TestLogin extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Test user login',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  color: themeData.colorScheme.onBackground),
            ),
            SizedBox(
              height: 44,
            ),
            SearchField(
                controller: emailController,
                label: Text('email'),
                onChanged: (value) {},
                isLoading: false,
                isSearchField: false),
            SizedBox(
              height: 12,
            ),
            SearchField(
                controller: passwordController,
                label: Text('password'),
                onChanged: (value) {},
                isLoading: false,
                isSearchField: false),
            SizedBox(
              height: 44,
            ),
            PrimaryButton(
              label: 'Log In',
              height: 56,
              isLoading: false, // You can use a ViewModel to manage this state
              color: themeData.colorScheme.primary,
              onTap: () async {
                final body = jsonEncode(<String, dynamic>{
                  "email_id": emailController.text.trim(),
                  "password": passwordController.text.trim(),
                });
                var url = Uri.parse(
                    'https://bharatposters.rpaventuresllc.com/signInUsingLoginPassword');
                var response = await http.post(url, body: body);

                if (response.statusCode == 200) {
                  Map<String, dynamic> responseData =
                      json.decode(response.body);
                  final token = responseData['token'];
                  final userId = responseData['appUserId'];

                  await TokenValidity(token, true);
                  await saveUserId(userId.toString());
                  await Authentication().configCall();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const NotificationView()));
                } else {
                  // Login failed, handle the response
                  print('Login failed: ${response.statusCode}');
                }
              },
              isEnabled: true,
            )
          ],
        ),
      ),
    );
  }

  Future<void> TokenValidity(String token, bool isValid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setBool('isTokenValid', isValid);
  }

  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    print("shared");
    print(userId);
  }
}
