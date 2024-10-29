import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:bharatposters0/screens/Login/loginviewmodel.dart';
import 'package:bharatposters0/screens/Login/testlogin.dart';
import 'package:bharatposters0/utils/authentication/authentication.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  int count = 0;
  final Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text('Bharat poster ',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            fontFamily: 'Work-Sans',
                            color: themeData.colorScheme.onBackground)),
                    const SizedBox(height: 4),
                    Text(
                      // 'भाजपा के दैनिक पोस्टर फोटो और नाम के साथ',
                      'Get your Posters in One Click',
                      // 'एक क्लिक में पायें पोस्टर अपनी फोटो के साथ',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Mukta',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    GestureDetector(
                        onTap: () => setState(() {
                              if (count < 10) {
                                count++;
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TestLogin()),
                                );
                              }
                              //TODO: test login settings here:
                            }),
                        child: Image.asset(
                          "Asset/Images/Onboarding-Asset-01.jpeg",
                          height: 244,
                        )),
                    const SizedBox(
                      height: 32.0,
                    ),
                    const SizedBox(
                      height: 44.0,
                    ),
                    PrimaryButton(
                      // isLoading: model.isLoading,
                      isEnabled: true,
                      onTap: () async {
                        // model.isLoading = true;
                        await _authentication.signInWithGoogle(context);
                        // model.isLoading = false;
                      },
                      height: 56,
                      label: 'Register',
                      iconPath: 'Asset/Icons/Google.svg',
                      color: themeData.colorScheme.primary,
                    ),
                    const Spacer(),
                    Text(
                      'By signing up you agree to our\n“Terms of Service” and “Privacy Policy',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                  ],
                ),
              ),
            ));
  }
}
