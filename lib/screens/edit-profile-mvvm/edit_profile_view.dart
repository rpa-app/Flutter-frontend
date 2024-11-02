import 'package:auto_route/annotations.dart';
import 'package:bharatposters0/screens/edit-profile-mvvm/edit_profile_viewmodel.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:bharatposters0/global/text_field.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import '../../../global/CustomSecondaryButton.dart';

@RoutePage()
class EditProfileView extends StatefulWidget {
  final VoidCallback? onDetailsSaved;
  const EditProfileView({super.key, this.onDetailsSaved});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ViewModelBuilder<EditProfileViewModel>.reactive(
        viewModelBuilder: () => EditProfileViewModel(),
        builder: (context, viewModel, child) => Scaffold(
              backgroundColor: themeData.colorScheme.background,
              body: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.grey.shade100,
                    // backgroundColor: themeData.colorScheme.background,
                    elevation: 1,
                    title: Text(
                      'Update your Profile',
                      // 'प्रोफाइल एडिट करें',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Mukta',
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      profileDetails(viewModel),
                      callToAction(viewModel),
                      SizedBox(
                        height: 44,
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget profileDetails(EditProfileViewModel viewModel) {
    return Column(
      children: [
        Text(
          'Profile Details',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 32,
        ),
        CustomTextField(
          label: 'Change Name',

          // label: 'नाम बदलें',
          controller: viewModel.nameController,
        ),
        SizedBox(
          height: 16,
        ),
        CustomTextField(
          label: 'Change Position',
          // label: 'पद बदलें',
          controller: viewModel.titleController,
        ),
        SizedBox(
          height: 16,
        ),
        CustomTextField(
          // label: 'नंबर बदलें',
          label: 'Change Number',
          controller: viewModel.numberController,
        ),
      ],
    );
  }

  Widget callToAction(EditProfileViewModel viewModel) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        SizedBox(height: 60),
        // Spacer(),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PrimaryButton(
              isEnabled: true,
              isLoading: false,
              onTap: () async {
                await viewModel.onSaved();
                widget.onDetailsSaved!.call();
                Navigator.pop(context);
              },
              color: themeData.colorScheme.primary,
              height: 50,
              label: 'Save and Exit',
              // label: 'सेव करके बंद करें',
            )),
        SizedBox(
          height: 8,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomSecondaryButton(
              leadingIcon: '',
              onPressed: () async {
                Navigator.pop(context);
              },
              // buttonText: 'बदलाव रद्द करें',
              buttonText: 'Cancel ',
              showIcon: false,
              buttonColor: Colors.transparent,
            )),
      ],
    );
  }
}
