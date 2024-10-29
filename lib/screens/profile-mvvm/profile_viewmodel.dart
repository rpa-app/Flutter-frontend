import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:bharatposters0/services/user_image_operations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import '../../services/user_db_operations.dart';

import '../../route/route.gr.dart';
import '../../services/photo_background_removal.dart';
import '../../utils/Singletons/prefs_singleton.dart';

class ProfileViewModel extends BaseViewModel {
  //instances
  final Prefs _prefs = Prefs.instance;
  Prefs get prefs => _prefs;
  //getters and setters
  String? get userName => _prefs.getString('Name');
  int? get selectedID => _prefs.getInt('SelectedID');

  // functions for business logic:
  void onTapChangeParty(context) {
    AutoRouter.of(context).replaceAll([PartyListViewRoute()]);
  }

  // void userImageChange(context) async {
  //   ThemeData themeData = Theme.of(context);
  //   XFile? image = await UserImage().pickImage(themeData);
  //   if (image == null) {
  //     //do nothing
  //   } else {
  //     await UserImage().addUserImage(image);
  //     await removeBackground(image, context);
  //   }
  //   notifyListeners();
  // }
  Future<void> userImageChange(BuildContext context) async {
    ThemeData themeData = Theme.of(context);
    XFile? image = await UserImage().pickImage(themeData);
    if (image != null) {
      await UserImage().addUserImage(image);
      await removeBackground(image, context);
      notifyListeners();
    }
  }

  Future<File?> getUserImage() async {
    String? imagePath = _prefs.getString('userImagePath');
    if (imagePath != null && imagePath.isNotEmpty) {
      return File(imagePath);
    }
    print("imagepath");
    print(imagePath);
    return null;
  }

  // Future<void> setSharedPreferences(
  //     String collection0, String collection1) async {
  //   //get prefs and number for update:
  //   int? number = _prefs.getInt('number');
  //   //update details in SharedPreferences:
  //   await _prefs.setString('Name', collection0);
  //   await _prefs.setString('Title', collection1);
  //   // update details on firebase:
  //   await UserDatabase(
  //           userName: collection0, userTitle: collection1, userPhone: number)
  //       .createUserDatabase();
  // }
  Future<Map<String, dynamic>> fetchBJPLabelData() async {
    // Simulate a fetch from a database or API
    await Future.delayed(Duration(seconds: 1));
    final String name = prefs.getString('Name') ?? '';
    final String title = prefs.getString('Title') ?? '';
    final String state = prefs.getString('CategorySelected') ?? '';
    print(name);
    print(title);

    File? userImage = await UserImage().returnSelectedUserImage(selectedID);
    return {
      'name': name,
      'position': title,
      'state': state,
      'image': userImage
    };
  }

  Future<List<String>> fetchLabelData() async {
    List<String> collection = [];
    final String name = prefs.getString('Name') ?? '';
    final String title = prefs.getString('Title') ?? '';
    // final int number = prefs.getInt('number') ?? 0;
    collection.add(name);
    collection.add(title);
    // collection.add(number.toString());
    print(name);
    return collection;
  }

  Future removeBackground(XFile? image, context) {
    ThemeData themeData = Theme.of(context);
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder(
              stream: PhotoBackgroundRemoval().executeEverything(image),
              builder: (context, snapshot) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Removing background, please wait..',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Work-Sans',
                        fontSize: 20,
                        color: themeData.colorScheme.onSurface),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Container(width: 300, child: snapshot.data),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    snapshot.connectionState == ConnectionState.done
                        ? PrimaryButton(
                            isEnabled: true,
                            isLoading: false,
                            onTap: () async {
                              AutoRouter.of(context).pop();
                            },
                            label: 'Add Image',
                            color: themeData.colorScheme.primary,
                          )
                        : SizedBox(),
                  ],
                );
              });
        });
  }
}
