import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/route/route.gr.dart';
import 'package:flutter/material.dart';

class DialogBox {
  static void showSessionTimeoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Session Timed Out'),
          content: Text('Your session has timed out. Please login again.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Route to login page
                AutoRouter.of(context).push(LoginViewRoute());
              },
            ),
          ],
        );
      },
    );
  }
}
