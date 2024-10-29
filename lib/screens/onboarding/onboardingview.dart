// }
import 'package:auto_route/annotations.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:bharatposters0/screens/onboarding/onboardingviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class OnboardingDetailsView extends StatefulWidget {
  const OnboardingDetailsView({super.key});

  @override
  State<OnboardingDetailsView> createState() => _OnboardingDetailsState();
}

class _OnboardingDetailsState extends State<OnboardingDetailsView> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ViewModelBuilder<OnboardingDetailsViewModel>.reactive(
      viewModelBuilder: () => OnboardingDetailsViewModel(),
      onViewModelReady: (model) async => await model.getUserDetails(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Column(
            children: [
              // Top Header Section
              Container(
                padding: const EdgeInsets.all(20),
                color: themeData.colorScheme.primary,
                child: Column(
                  children: [
                    Center(
                      child: Lottie.asset(
                        'Asset/Lottie/usericon.json', // Add a new user-themed Lottie animation
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Let's Get Started",
                      style: themeData.textTheme.headline6?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Complete your profile to access personalized posters",
                      textAlign: TextAlign.center,
                      style: themeData.textTheme.bodyText2?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // Form Fields Section with Padding
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Phone Number Field
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: 'Enter your phone number',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: viewModel.numberController,
                      ),
                      const SizedBox(height: 16),
                      // Name Field
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'e.g., Akash Gupta',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: viewModel.nameController,
                      ),
                      const SizedBox(height: 16),
                      // Position Field
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Your Position',
                          hintText: 'e.g., Party President',
                          prefixIcon: Icon(Icons.work),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: viewModel.titleController,
                      ),
                    ],
                  ),
                ),
              ),

              // Floating Submit Button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: PrimaryButton(
                  color: themeData.colorScheme.secondary,
                  label: 'Submit Details',
                  height: 56,
                  isLoading: false,
                  isEnabled: viewModel.isEnabled,
                  onTap: () {
                    if (viewModel.numberController.text.length != 10) {
                      _showWarningSnackbar(context);
                    } else {
                      viewModel.onSaved(isTestUser: false, context: context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWarningSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            LottieBuilder.asset(
              'Asset/Lottie/warning1.json',
              height: 36,
            ),
            const SizedBox(width: 12),
            const Text(
              'Please enter a valid 10-digit phone number.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
