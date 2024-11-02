import 'dart:async';
import 'dart:io';
import 'package:bharatposters0/services/permissionservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserImage {
  Future<XFile?> pickImage(ThemeData themeData) async {
    //initializing image picker, XFile image picks image from gallery
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      final CroppedFile? croppedImage =
          await ImageCropper().cropImage(sourcePath: image!.path, uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarWidgetColor: Colors.black,
          toolbarColor: Colors.green.shade200,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ]);
      final XFile newCroppedImage = XFile(croppedImage!.path);
      return newCroppedImage;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addUserImage(XFile? image) async {
    //checks permission access to write or not
    PermissionAccess().requestStoragePermission();
    final prefs = await SharedPreferences.getInstance();

    //Fetching app document and shared preferences to get user image ID
    final appDir = await getApplicationDocumentsDirectory();

    // checks if profile photo folder is created or not. If not created, then creates one.
    final profilePhotoDir = Directory('${appDir.path}/Profile Photo');
    if (!await profilePhotoDir.exists()) {
      await profilePhotoDir.create(recursive: true);
    }

    //photo IDs stored in shared preferences to tell us how many photos to fetch
    int? photoID = prefs.getInt('Photo ID');

    if (image != null) {
      //if photoID is null, set it to 0 and add the image
      if (photoID == null) {
        // setting photoID to 0 and caching the value in preferences for getting value everywhere else.
        // setting selected ID to 0 as well since this is the first photo in the stack
        photoID = 0;
        prefs.setInt('Photo ID', 0);
        prefs.setInt('SelectedID', 0);

        //adding image to directory:
        final profilePhotoFile =
            File('${profilePhotoDir.path}/profile-photo-$photoID.jpg');
        await profilePhotoFile.writeAsBytes(await image.readAsBytes());

        // returning selected user image:
        // returnSelectedUserImage(photoID);
      } else {
        // first we set photoID+1, so that we can add up new profile photos.
        photoID++;
        //caching photo ID, selected ID for the new stack
        await prefs.setInt('Photo ID', photoID);
        await prefs.setInt('SelectedID', photoID);

        //writing the photo to the directory
        final profilePhotoFile =
            File('${profilePhotoDir.path}/profile-photo-$photoID.jpg');
        await profilePhotoFile.writeAsBytes(await image.readAsBytes());
      }
    } else {
      //do nothing
    }
  }

  Future<void> addLeaderImage(XFile? image) async {
    //checks permission access to write or not
    PermissionAccess().requestStoragePermission();
    final prefs = await SharedPreferences.getInstance();

    //Fetching app document and shared preferences to get user image ID
    final appDir = await getApplicationDocumentsDirectory();

    // checks if profile photo folder is created or not. If not created, then creates one.
    final profilePhotoDir = Directory('${appDir.path}/leader Photo');
    if (!await profilePhotoDir.exists()) {
      await profilePhotoDir.create(recursive: true);
    }

    //photo IDs stored in shared preferences to tell us how many photos to fetch
    int? photoID = prefs.getInt('leader ID');

    if (image != null) {
      //if photoID is null, set it to 0 and add the image
      if (photoID == null) {
        // setting photoID to 0 and caching the value in preferences for getting value everywhere else.
        // setting selected ID to 0 as well since this is the first photo in the stack
        photoID = 0;
        prefs.setInt('leader ID', 0);
        prefs.setInt('leaderSelectedID', 0);

        //adding image to directory:
        final profilePhotoFile =
            File('${profilePhotoDir.path}/leader-photo-$photoID.jpg');
        await profilePhotoFile.writeAsBytes(await image.readAsBytes());

        // returning selected user image:
        // returnSelectedUserImage(photoID);
      } else {
        // first we set photoID+1, so that we can add up new profile photos.
        photoID++;
        //caching photo ID, selected ID for the new stack
        await prefs.setInt('leader ID', photoID);
        await prefs.setInt('leaderSelectedID', photoID);

        //writing the photo to the directory
        final profilePhotoFile =
            File('${profilePhotoDir.path}/leader-photo-$photoID.jpg');
        await profilePhotoFile.writeAsBytes(await image.readAsBytes());
      }
    } else {
      //do nothing
    }
  }

  Future<dynamic> returnSelectedUserImage(int? selectedID) async {
    // creating a conditional widget which is shown in case null value:
    // Widget conditionalImage = Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     SvgPicture.asset('Asset/SVG/Image-Box.svg'),
    //     const SizedBox(
    //       height: 24,
    //       width: 24,
    //     ),
    //     const Text('ADD YOUR PHOTO',
    //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
    //   ],
    // );

    // if check for photo ID == null
    if (selectedID == null) {
      return null;
    } else {
      //returning image for selectedID by getting the file from directory:
      final appDir = await getApplicationDocumentsDirectory();
      final profilePhotoDir = Directory('${appDir.path}/Profile Photo');
      final profilePhotoFile =
          File('${profilePhotoDir.path}/profile-photo-$selectedID.jpg');
      return profilePhotoFile;
    }
  }

  Future<dynamic> returnSelectedLeaderImage(int? selectedID) async {
    // creating a conditional widget which is shown in case null value:
    // Widget conditionalImage = Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     SvgPicture.asset('Asset/SVG/Image-Box.svg'),
    //     const SizedBox(
    //       height: 24,
    //       width: 24,
    //     ),
    //     const Text('ADD YOUR PHOTO',
    //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
    //   ],
    // );

    // if check for photo ID == null
    if (selectedID == null) {
      return null;
    } else {
      //returning image for selectedID by getting the file from directory:
      final appDir = await getApplicationDocumentsDirectory();
      final profilePhotoDir = Directory('${appDir.path}/leader Photo');
      final profilePhotoFile =
          File('${profilePhotoDir.path}/leader-photo-$selectedID.jpg');
      print(profilePhotoFile);
      return profilePhotoFile;
    }
  }

  Future returnListFileAddress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final appDir = await getApplicationDocumentsDirectory();
      final int? photoID = prefs.getInt('Photo ID');
      final profilePhotoDir = Directory('${appDir.path}/Profile Photo');

      if (photoID != null && await profilePhotoDir.exists()) {
        List<File> photoFiles = [];

        for (int i = photoID; i >= 0; i--) {
          File profilePhotoFile =
              File('${profilePhotoDir.path}/profile-photo-$i.jpg');
          if (await profilePhotoFile.exists()) {
            photoFiles.add(profilePhotoFile);
          }
        }
        return photoFiles;
      } else {
        return null; // Return null if no photo files or directory not found
      }
    } catch (e) {
      // print('Error while retrieving profile photo files: $e');
      return e; // Return null in case of any errors
    }
  }

  // Future removePhoto(
  //     int selectedFile,
  //     int? photoID, int?
  //     selectedPrefs,
  //     SharedPreferences prefs
  //     ) async {
  //
  //   final appDir = await getApplicationDocumentsDirectory();
  //   final profilePhotoDir = Directory('${appDir.path}/Profile Photo');
  //
  //   final selectedFileOld = File('${profilePhotoDir.path}/profile-photo-$selectedFile.jpg');
  //   final selectedFileTemp = File('${profilePhotoDir.path}/profile-photo-temp.jpg');
  //
  //   // Rename the selected file to a temporary name
  //   await selectedFileOld.rename(selectedFileTemp.path);
  //
  //   // Delete the selected file
  //   await selectedFileTemp.delete();
  //
  //   // Rename the remaining files
  //   for (int i = selectedFile + 1; i <= photoID!; i++) {
  //     final fileOld = File('${profilePhotoDir.path}/profile-photo-$i.jpg');
  //     final fileNew = File('${profilePhotoDir.path}/profile-photo-${i - 1}.jpg');
  //     await fileOld.renameSync(fileNew.path);
  //   }
  //
  //   await prefs.setInt('Photo ID', photoID - 1);
  //
  //   if(selectedFile == 0 && selectedFile != selectedPrefs){
  //     //do nothing
  //   } else if(selectedFile == 0 && selectedFile == selectedPrefs){
  //     await prefs.setInt('SelectedID', selectedFile + 1);
  //   } else if(selectedFile == selectedPrefs && selectedFile != 0){
  //     await prefs.setInt('SelectedID', selectedFile - 1);
  //   } else {
  //     await prefs.setInt('SelectedID', selectedFile-1);
  //   }
  // }
}
