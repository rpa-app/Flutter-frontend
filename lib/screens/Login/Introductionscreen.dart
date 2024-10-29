import 'package:bharatposters0/route/route.gr.dart';
import 'package:bharatposters0/screens/Login/introductiopage.dart';
import 'package:bharatposters0/screens/Login/loginview.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _pages = [
    OnboardingPage(
      title: "Welcome to Bharat Posters",
      description: "Get access to a variety of political posters.",
      image: "Asset/Images/componenttwo.jpg",
    ),
    OnboardingPage(
      title: "Customize Your Posters",
      description: "Create personalized posters for your needs.",
      image: "Asset/Images/componentfirst.webp",
    ),
    OnboardingPage(
      title: "Share with Friends",
      description: "Easily share your posters with others.",
      image: "Asset/Images/componenttwo.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return _pages[index];
        },
      ),
      bottomSheet: _currentPage == _pages.length - 1
          ? Container(
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()));
                },
                child: Text("Get Started"),
              ),
            )
          : Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      AutoRouter.of(context).replace(const LoginViewRoute());
                    },
                    child: Text("Skip"),
                  ),
                  TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            ),
    );
  }
}
