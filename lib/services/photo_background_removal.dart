import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bharatposters0/services/permissionservice.dart';
import 'package:bharatposters0/services/user_image_operations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class PhotoBackgroundRemoval {
  Stream executeEverything(XFile? image) async* {
    final controller = StreamController.broadcast();
    final sharedPrefs = await SharedPreferences.getInstance();

    Widget processingWidget = Stack(
      alignment: Alignment.center,
      children: [
        Image.file(File(image!.path)),
        Container(
          color: Colors.black.withAlpha(150),
        ),
        LinearProgressIndicator(
              backgroundColor: Colors.white.withOpacity(0.3),
              color: Colors.white,
            ),
            SizedBox(height: 8),
        Text(
          '',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );

    Widget errorWidget = Column(
      children: [
        Icon(
          Icons.info,
          size: 48,
          color: Colors.black.withAlpha(100),
        ),
        SizedBox(height: 24),
        Text(
          'Could not process. Please try again later or with different image',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );

    try {
      String? croppedURL = await newImageUpload(image);
      int rateLimiter = 1;

      var appDirectory = await getApplicationDocumentsDirectory();
      File file = File('${appDirectory.path}/dummy_path_${DateTime.now().millisecondsSinceEpoch}');
    
      Timer.periodic(const Duration(seconds: 3), (timer) async {
        if (timer.tick == 1) {
          controller.add(processingWidget);
        }

        var response = await http.get(Uri.parse(croppedURL!));
        file.writeAsBytesSync(response.bodyBytes);

        if (rateLimiter >= 10) {
          timer.cancel();
          controller.add(errorWidget);
          controller.close();
        }

        if (response.statusCode == 200) {
          XFile? addImageFile = XFile(file.path);

          await UserImage().addUserImage(addImageFile);

          // print('image downloaded success');
          var processedWidget = Image.file(File(addImageFile.path));
          sharedPrefs.setString('lastFetchedURL', '');
          timer.cancel();
          controller.add(processedWidget);
          controller.close();
        } else {
          sharedPrefs.setString('lastFetchedURL', croppedURL);
          rateLimiter++;
        }
      });
    } catch (error) {
      controller.addError(error);
      controller.close();
      print('error: $error');
    }

    await for (var event in controller.stream) {
      yield event;
    }
  }

  // Stream executeEverythingLeader(XFile? image  ) async* {
  //   final controller = StreamController.broadcast();
  //   final sharedPrefs = await SharedPreferences.getInstance();

  //   Widget processingWidget = Stack(
  //     alignment: Alignment.center,
  //     children: [
  //       Image.file(File(image!.path)),
  //       Container(
  //         color: Colors.black.withAlpha(150),
  //       ),
  //       CircularProgressIndicator(
  //         color: Colors.white,
  //       ),
  //     ],
  //   );

  //   Widget errorWidget = Column(
  //     children: [
  //       Icon(
  //         Icons.info,
  //         size: 48,
  //         color: Colors.black.withAlpha(100),
  //       ),
  //       SizedBox(height: 24),
  //       Text(
  //         'Could not process. Please try again later or with different image',
  //         style: TextStyle(
  //           fontWeight: FontWeight.w400,
  //           fontSize: 16,
  //         ),
  //         textAlign: TextAlign.center,
  //       )
  //     ],
  //   );

  //   try {
  //     String? croppedURL = await newImageUpload(image);
  //     int rateLimiter = 1;

  //     var appDirectory = await getApplicationDocumentsDirectory();
  //     File file = File(appDirectory.path + 'dummy_path');

  //     Timer.periodic(const Duration(seconds: 3), (timer) async {
  //       if (timer.tick == 1) {
  //         controller.add(processingWidget);
  //       }

  //       var response = await http.get(Uri.parse(croppedURL!));
  //       file.writeAsBytesSync(response.bodyBytes);

  //       if (rateLimiter >= 10) {
  //         timer.cancel();
  //         controller.add(errorWidget);
  //         controller.close();
  //       }

  //       if (response.statusCode == 200) {
  //         XFile? addImageFile = XFile(file.path);

  // await UserImage().addLeaderImage(addImageFile);

  //         // print('image downloaded success');
  //         var processedWidget = Image.file(File(addImageFile.path));
  //       sharedPrefs.setString('lastFetchedURLl', '');
  //         timer.cancel();
  //         controller.add(processedWidget);
  //         controller.close();
  //       } else {
  //           sharedPrefs.setString('lastFetchedURLl', croppedURL);
  //         rateLimiter++;
  //       }
  //     });
  //   } catch (error) {
  //     controller.addError(error);
  //     controller.close();
  //     print('error: $error');
  //   }

  //   await for (var event in controller.stream) {
  //     yield event;
  //   }
  // }

  Future<String?> newImageUpload(XFile? imageFile) async {
    XFile? croppedFile = await cropImage(imageFile);

    var request = http.MultipartRequest(
      'POST', // Change the request method to POST
      Uri.parse('https://bharatposters.rpaventuresllc.com/removebackground'),
    );

    // Add image file to the request with the correct part name
    request.files
        .add(await http.MultipartFile.fromPath('file', croppedFile!.path));

    // Set headers
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? userId = prefs.getString('userId');

    request.headers.addAll({
      'token': token ?? '',
      'appUserId': userId ?? '',
    });

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var responseDataURL = jsonDecode(response.body);
        String imageURL = responseDataURL["url"];
        print("succcesfully taken the image");
        return imageURL;
      } else {
        print(response.statusCode);
        print('Error uploading image. Response: ${response.body}');
      }
    } catch (e) {
      print('Error uploading image, caught exception: $e');
    }
    return null;
  }

  // Future newImageUpload(XFile? imageFile) async {
  //   final croppedFile = await cropImage(imageFile);

  //   var request = http.MultipartRequest(
  //     'GET',
  //     Uri.parse('https://neta-backend.netaapp.in/poster/user/v1/image'),
  //   );

  //   request.files.add(
  //     await http.MultipartFile.fromPath('file', croppedFile!.path),
  //   );

  //   try {
  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       var responseData = await response.stream.bytesToString();
  //       var responseDataURL = jsonDecode(responseData);
  //       String imageURL = responseDataURL["img_url"];
  //       return imageURL;
  //     } else {
  //       print('Error uploading image. Response: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //   }
  // }

  Future<XFile?> cropImage(XFile? file) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file!.path);
    var _resizedImage = await FlutterNativeImage.compressImage(file.path,
        targetWidth: 800,
        targetHeight: (properties.height! * 800 / (properties.width)!).round());
    return XFile(_resizedImage.path);
  }

  Future<void> addUserImage(image) async {
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
            File('${profilePhotoDir.path}/profile-photo-$photoID.png/cropped');
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
            File('${profilePhotoDir.path}/profile-photo-$photoID.jpg/cropped');
        await profilePhotoFile.writeAsBytes(await image.readAsBytes());
        // print('photo added to directory');
      }
    } else {
      //do nothing
    }
  }
}
