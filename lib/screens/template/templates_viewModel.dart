import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:bharatposters0/global/processvideo.dart';
import 'package:bharatposters0/services/user_image_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../services/download_share_image.dart';

import '../../../utils/Singletons/prefs_singleton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class TemplatesViewModel extends BaseViewModel {
  //instances
  final Prefs _prefs = Prefs.instance;

  //getters and setters
  int? get selectedID => _prefs.getInt('SelectedID');

  String _selectedCategory = '';
  String get selectedCategory => _selectedCategory;
  set selectedCategory(value) {
    _selectedCategory = value;
    notifyListeners();
  }

  Color _containerColor = HexColor('#FFFFFF');
  Color get containerColor => _containerColor;
  set containerColor(value) {
    _containerColor = value;
    notifyListeners();
  }

  // bool _premiumStatus = false;
  // bool get premiumStatus => _premiumStatus;
  // set premiumStatus(value) {
  //   _premiumStatus = value;
  //   notifyListeners();
  // }

  late List<String> _userDetails;
  List<String> get userDetails => _userDetails;
  set userDetails(value) {
    userDetails = value;
  }

  //functions for view
  Future initialize() async {
    _selectedCategory = _prefs.getString('CategorySelected') ?? '';
    await fetchUserDetails(isTestUser: false);
    setContainerColor();
    notifyListeners();
  }

  Future fetchUserDetails({required bool isTestUser}) async {
    List<String> _details = [];
    String userName = _prefs.getString('Name') ?? '';
    String userTitle = _prefs.getString('Title') ?? '';
    _details.addAll([userName, userTitle]);
    _userDetails = _details;
  }

  Future<Widget> userImage() async {
    if (selectedID != null) {
      var userImage = await UserImage().returnSelectedUserImage(selectedID);
      return Image.file(
        userImage,
        fit: BoxFit.contain,
        width: 260,
        height: 260,
        alignment: Alignment.bottomCenter,
      );
    } else {
      return Container(
          child: SvgPicture.asset(
        'Asset/SVG/ImagePlaceholder.svg',
        fit: BoxFit.contain,
      ));
    }
  }

  Future<Widget> leaderImage() async {
    if (selectedID != null) {
      var userImage = await UserImage().returnSelectedUserImage(selectedID);
      return Image.file(
        userImage,
        fit: BoxFit.contain,
        width: 260,
        height: 260,
        alignment: Alignment.bottomCenter,
      );
    } else {
      return Container(
          child: SvgPicture.asset(
        'Asset/SVG/ImagePlaceholder.svg',
        fit: BoxFit.contain,
      ));
    }
  }

  Future<Widget> userImages() async {
    if (selectedID != null) {
      var userImage = await UserImage().returnSelectedUserImage(selectedID);
      return Image.file(
        userImage,
        fit: BoxFit.contain,
        width: 260,
        height: 260,
        alignment: Alignment.bottomCenter,
      );
    } else {
      return Container(
          child: SvgPicture.asset(
        'Asset/SVG/ImagePlaceholder.svg',
        fit: BoxFit.contain,
      ));
    }
  }

  void setContainerColor() {
    switch (_selectedCategory) {
      case 'BJP':
        {
          _containerColor = HexColor('#F97D09');
          notifyListeners();
          break;
        }
      case 'Congress':
        {
          _containerColor = HexColor('#0e813e');
          notifyListeners();
          break;
        }
      case 'BSP':
        {
          _containerColor = HexColor('#2747b6');
          notifyListeners();
          break;
        }
      case 'SP':
        {
          containerColor = HexColor('#0e6c37');
          notifyListeners();
          break;
        }
      case 'AAP':
        {
          containerColor = HexColor('#1073ac');
          notifyListeners();
          break;
        }
      default:
        containerColor = HexColor('#F97D09');
        break;
    }
  }

  Future<XFile?> userImageChange(context) async {
    ThemeData themeData = Theme.of(context);
    var image = await UserImage().pickImage(themeData);
    await UserImage().addUserImage(image);
    return image;
  }

  Map<String, String> processedVideoCache = {};

// Function to generate a unique identifier
  String generateUniqueIdentifier(String videoUrl) {
    return md5.convert(utf8.encode(videoUrl)).toString();
  }

  Future<void> conditionalButtonClick1({
    required ScreenshotController controller,
    required BuildContext context,
    required premiumStatus,
    required bool isPoster,
    required String imageUrl,
    required bool isTestUser,
    required Function setLoading,
    required ScreenshotController userController,
  }) async {
    int? selectedID = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getInt('SelectedID'));
    if (selectedID == null) {
      await showPhotoWarning(premiumStatus, context);
      print("abcd");
      print(premiumStatus);
    } else {
      if (isPoster) {
        if (premiumStatus) {
          DownloadShareImage(controller: controller).shareScreenshot();
        } else {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PremiumView(
          //       imageUrl: imageUrl,
          //       isPoster: isPoster,
          //       isTestUser: isTestUser,
          //     ),
          // ),
          // );
        }
      } else {
        // Generate a unique identifier for the video
        String uniqueIdentifier = generateUniqueIdentifier(imageUrl);

        String? processedVideoPath = processedVideoCache[uniqueIdentifier];
        if (processedVideoPath == null) {
          setLoading(true);
          // Process video with overlay
          List<String> imagePaths = await getImageList();
          print('Image paths: $imagePaths'); // Debug print

          processedVideoPath = await processVideoWithOverlay(
            imageUrl,
            imagePaths,
            uniqueIdentifier,
            controller,
            userController,
          );
          print('Original video path: $imageUrl');
          print('Processed video path: $processedVideoPath');

          // Save the processed video path in the cache
          processedVideoCache[uniqueIdentifier] = processedVideoPath;
          setLoading(false);
        } else {
          print('Using cached processed video path: $processedVideoPath');
        }

        if (premiumStatus) {
          DownloadShareImage().shareVideos(processedVideoPath);
          print(processedVideoPath);
        } else {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PremiumView(
          //       imageUrl: processedVideoPath ?? '',
          //       isPoster: isPoster,
          //       isTestUser: isTestUser,
          //     ),
          //   ),
          // );
        }
      }
    }
  }

  // Future<void> conditionalButtonClick1({
  //   required ScreenshotController controller,
  //   required BuildContext context,
  //   required premiumStatus,
  //   required bool isPoster,
  //   required String imageUrl,
  //   required bool isTestUser,
  //   required Function setLoading,
  //   // required GlobalKey stripKey,
  // }) async {
  //   int? selectedID = await SharedPreferences.getInstance()
  //       .then((prefs) => prefs.getInt('SelectedID'));
  //   if (selectedID == null) {
  //     // await showPhotoWarning(premiumStatus, context);
  //     print("abcd");
  //     print(premiumStatus);
  //   } else {
  //     // Generate a unique identifier for the video
  //     String uniqueIdentifier = generateUniqueIdentifier(imageUrl);

  //     String? processedVideoPath = processedVideoCache[uniqueIdentifier];
  //     if (processedVideoPath == null) {
  //       setLoading(true);
  //       // Process video with overlay
  //       // File stripFile = await captureStripAsImage(stripKey);
  //       List<String> imagePaths = await getImageList();
  //       // String StripPath =  (stripFile.path);
  //       print('Image paths: $imagePaths'); // Debug print

  //       processedVideoPath = await processVideoWithOverlay(
  //         imageUrl, imagePaths, uniqueIdentifier,
  //         //  stripFile.path
  //       );
  //       print('Original video path: $imageUrl');
  //       print('Processed video path: $processedVideoPath');

  //       // Save the processed video path in the cache
  //       processedVideoCache[uniqueIdentifier] = processedVideoPath;
  //       setLoading(false);
  //     } else {
  //       print('Using cached processed video path: $processedVideoPath');
  //     }
  //     // setLoading(false); // Hide loader

  //     if (premiumStatus) {
  //       if (isPoster) {
  //         DownloadShareImage(controller: controller).shareScreenshot();
  //       } else {
  //         DownloadShareImage().shareVideos(processedVideoPath);
  //         print(processedVideoPath);
  //       }
  //     } else {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PremiumView(
  //             imageUrl: isPoster ? imageUrl : processedVideoPath ?? '',
  //             isPoster: isPoster,
  //             isTestUser: isTestUser,
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }

  // Future<void> conditionalButtonClick1({
  //   required ScreenshotController controller,
  //   required BuildContext context,
  //   required premiumStatus,
  //   required bool isPoster,
  //   required String imageUrl,
  //   required bool isTestUser,
  //   //  required int videoIndex,
  // }) async {
  //   int? selectedID = await SharedPreferences.getInstance()
  //       .then((prefs) => prefs.getInt('SelectedID'));
  //   if (selectedID == null) {
  //     // await showPhotoWarning(premiumStatus, context);
  //     print("abcd");
  //     print(premiumStatus);
  //   } else if (premiumStatus) {
  //     List<String> imagePaths = await getImageList();
  //     print('Image paths: $imagePaths'); // Debug print

  //     String processedVideoPath =
  //         await processVideoWithOverlay(imageUrl, imagePaths);
  //     print('Original video path: $imageUrl');
  //     print('Processed video path: $processedVideoPath');

  //     if (isPoster) {
  //       DownloadShareImage(controller: controller).shareScreenshot();
  //     } else {
  //       DownloadShareImage().shareVideos(processedVideoPath);
  //       print(imageUrl);
  //     }
  //   } else {
  //     // Process video with overlay and navigate to the premium screen
  //     List<String> imagePaths = await getImageList();
  //     print('Image paths: $imagePaths'); // Debug print

  //     String processedVideoPath =
  //         await processVideoWithOverlay(imageUrl, imagePaths);
  //     print('Original video path: $imageUrl');
  //     print('Processed video path: $processedVideoPath');

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PremiumView(
  //           imageUrl: processedVideoPath,
  //           isPoster: isPoster,
  //           isTestUser: isTestUser,
  //         ),
  //       ),
  //     );
  //   }
  // }

  void conditionalButtonClick(
      {required ScreenshotController controller,
      required BuildContext context,
      required premiumStatus,
      required bool isPoster,
      required String imageUrl,
      required bool isTestUser}) async {
    int? selectedID = _prefs.getInt('SelectedID');
    if (selectedID == null) {
      await showPhotoWarning(premiumStatus, context);
      print("abcd");
      print(premiumStatus);
    } else if (premiumStatus) {
      if (isPoster) {
        DownloadShareImage(controller: controller).shareScreenshot();
      } else {
        DownloadShareImage().shareVideo(imageUrl);
      }
    } else {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => PremiumView(
      //       imageUrl: imageUrl,
      //       isTestUser: isTestUser,
      //       isPoster: isPoster,
      //     ),
      //   ),
      // );
    }
    //   AutoRouter.of(context)
    //       .push(PremiumViewRoute(imageUrl: imageUrl, isTestUser: isTestUser,isPoster: isPoster,));
    // }
  }
  //   if (selectedID == null) {
  //     await showPhotoWarning(premiumStatus, context);
  //     print("abcd");
  //     print(premiumStatus);
  //   } else if (premiumStatus) {
  //     DownloadShareImage(controller: controller).shareScreenshot();
  //   } else {
  //     AutoRouter.of(context)
  //         .push(PremiumViewRoute(imageUrl: imageUrl, isTestUser: isTestUser));
  //   }
  // }

  Future showPhotoWarning(premiumStatus, context) {
    ThemeData themeData = Theme.of(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: ListBody(
                children: [
                  LottieBuilder.asset(
                    'Asset/Lottie/alert.json',
                    height: 84,
                    width: 84,
                  ),
                  Text(
                    'Please upload photo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              )),
            ),
            actions: [
              PrimaryButton(
                isEnabled: true,
                isLoading: false,
                onTap: () async {
                  await userImageChange(context);
                  // if(isPhotoAdded){Navigator.pop(context);}
                },
                label: 'Upload Photo',
                color: themeData.colorScheme.primary,
              )
            ],
          );
        });
  }

  // Future<Map<String, dynamic>> fetchStateInfos() async {
  //   final configUrl =
  //       Uri.parse('https://neta-backend.netaapp.in/poster/config/v1/config');
  //   try {
  //     final response = await http.get(configUrl);
  //     if (response.statusCode == 200) {
  //       await Prefs.instance.setString('config', response.body);
  //       print("config");
  //       print(response.body);
  //       final prefs = await SharedPreferences.getInstance();
  //       final String? token = prefs.getString('token');
  //       final String? userId = prefs.getString('userId');
  //       print(userId);
  //       print(token);
  //     } else {
  //       // Handle error
  //       print('Failed to load config: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle network error
  //     print('Failed to load config: $e');
  //   }
  //   String? configJson = _prefs.getString('config');
  //   if (configJson != null) {
  //     Map<String, dynamic> config =
  //         jsonDecode(utf8.decode(configJson.codeUnits));
  //     List<dynamic> stateInfos = config['stateInfos'];
  //     var stateName = _prefs.getString('CategorySelected');

  //     final selectedStateInfo = stateInfos.firstWhere(
  //       (info) => info["state"] == stateName,
  //       orElse: () => null,
  //     );
  //     print(stateName);
  //     print(selectedStateInfo["leadersImgUrls"]);

  //     return {
  //       "stateName": stateName,
  //       "data":
  //           selectedStateInfo != null ? selectedStateInfo["leadersImgUrls"] : {}
  //     };
  //   } else {
  //     return {};
  //   }
  // }
  // Future<List<String>> getSelectedStateInfo2(
  //     String state, String partyName) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? configJson = prefs.getString('config');

  //   if (configJson != null) {
  //     Map<String, dynamic> config =
  //         jsonDecode(utf8.decode(configJson.codeUnits));
  //     List<dynamic> stateInfos = config['stateInfos'];

  //     // Print stateInfos for debugging
  //     print("State Infos: $stateInfos");

  //     // Find the state info
  //     Map<String, dynamic>? selectedStateInfo = stateInfos.firstWhere(
  //       (info) => info['state'].toString().toUpperCase() == state.toUpperCase(),
  //       orElse: () => null,
  //     );

  //     if (selectedStateInfo != null) {
  //       List<dynamic> parties = selectedStateInfo['partyInfoList'];

  //       // Print parties for debugging
  //       print("Parties: $parties");

  //       // Find the party info within the state
  //       Map<String, dynamic>? selectedPartyInfo = parties.firstWhere(
  //         (party) =>
  //             // party['partyName'].toString().toUpperCase() ==
  //             // partyName.toUpperCase(),
  //             party['partyId'].toString().toUpperCase().replaceAll('_', '') ==
  //             partyName.toUpperCase().replaceAll('_', ''),
  //         orElse: () => null,
  //       );

  //       if (selectedPartyInfo != null) {
  //         List<dynamic> imgs = selectedPartyInfo['leadersImgUrls'];
  //         return imgs.cast<String>();
  //       } else {
  //         print("No party found with name: $partyName");
  //       }
  //     } else {
  //       print("No state found with name: $state");
  //     }
  //   } else {
  //     print("Config JSON is null");
  //   }
  //   return [];
  // }

  Future<List<String>> getSelectedStateInfo2(
      String state, String partyName) async {
    final prefs = await SharedPreferences.getInstance();
    String? configJson = prefs.getString('config');

    if (configJson != null) {
      Map<String, dynamic> config =
          jsonDecode(utf8.decode(configJson.codeUnits));
      List<dynamic> stateInfos = config['stateInfos'];
      List<dynamic> otherStateInfos = config['otherStateInfos'];

      // Print stateInfos and otherStateInfos for debugging
      print("State Infos: $stateInfos");
      print("Other State Infos: $otherStateInfos");

      // Helper function to find state info
      Map<String, dynamic>? findStateInfo(List<dynamic> infos) {
        return infos.firstWhere(
          (info) =>
              info['state'].toString().toUpperCase() == state.toUpperCase(),
          orElse: () => null,
        );
      }

      // Search in both lists
      Map<String, dynamic>? selectedStateInfo =
          findStateInfo(stateInfos) ?? findStateInfo(otherStateInfos);

      if (selectedStateInfo != null) {
        List<dynamic> parties = selectedStateInfo['partyInfoList'];

        // Print parties for debugging
        print("Parties: $parties");

        // Find the party info within the state
        Map<String, dynamic>? selectedPartyInfo = parties.firstWhere(
          (party) =>
              party['partyId'].toString().toUpperCase().replaceAll('_', '') ==
              partyName.toUpperCase().replaceAll('_', ''),
          orElse: () => null,
        );

        if (selectedPartyInfo != null) {
          List<dynamic> imgs = selectedPartyInfo['leadersImgUrls'];
          print("Images received: $imgs");
          return imgs.cast<String>();
        } else {
          print("No party found with name: $partyName");
        }
      } else {
        print("No state found with name: $state");
      }
    } else {
      print("Config JSON is null");
    }
    return [];
  }

  Future<List<String>> getSelectedStateInfo1(String state, String Party) async {
    final prefs = await SharedPreferences.getInstance();
    String? configJson = prefs.getString('config');

    if (configJson != null) {
      Map<String, dynamic> config =
          jsonDecode(utf8.decode(configJson.codeUnits));
      List<dynamic> stateInfos = config['stateInfos'];
      Map<String, dynamic>? selectedStateInfo = stateInfos.firstWhere(
        (info) => info['state'] == state,
        orElse: () => null,
      );
      print("leaderstate$selectedStateInfo");
      if (selectedStateInfo != null) {
        List<dynamic> parties = selectedStateInfo['partyInfoList'];
        List<String> leaderImgUrls = [];
        print("leader123:$leaderImgUrls");
        for (var party in parties) {
          List<dynamic> imgs = party['leadersImgUrls'];
          leaderImgUrls.addAll(imgs.cast<String>());
        }
        return leaderImgUrls;
      }
    }
    return [];
  }

  Future<List<Map<String, String>>> getSelectedStateInfo(String state) async {
    String? configJson = _prefs.getString('config');
    if (configJson != null) {
      Map<String, dynamic> config =
          jsonDecode(utf8.decode(configJson.codeUnits));
      List<dynamic> stateInfos = config['stateInfos'];
      Map<String, dynamic>? selectedStateInfo = stateInfos.firstWhere(
        (info) => info['state'] == state,
        orElse: () => null,
      );
      if (selectedStateInfo != null) {
        List<dynamic> parties = selectedStateInfo['partyInfoList'];
        List<Map<String, String>> partyInfoList = parties.map((party) {
          return {
            // 'partyName': party['partyName'] as String,
            // 'partyLogo': party['partyLogo'] as String,
            'leadersImgUrls': party['leadersImgUrls'] as String,
          };
        }).toList();
        return partyInfoList;
      }
    }
    return [];
  }

  List<String> _imageData = [];
  List<String> get imageData => _imageData;

  // void addImage(String imagePath) {
  //  if (!_imageData.contains(imagePath)) {
  //     _imageData.add(imagePath);
  //     notifyListeners(); // Notify listeners to update UI
  //   } // Notify listeners to update UI
  // }
  void addImage(dynamic imagePath) async {
    String pathToAdd = imagePath is File ? imagePath.path : imagePath;

    if (!_imageData.contains(pathToAdd)) {
      _imageData.add(pathToAdd);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve the existing list
      List<String> existingList = prefs.getStringList('my_string_list') ?? [];

      // Add the new item to the list
      existingList.add(pathToAdd);

      // Save the updated list back to SharedPreferences
      await prefs.setStringList('my_string_list', existingList);

      //     final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setStringList('my_string_list',  _imageData);

      notifyListeners();
    }
  }

  Future<List<String>> getImageList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('my_string_list') ?? [];
  }

  void removeImage(dynamic imagePath, [File? fileImagePath]) async {
    String pathToRemove = imagePath is File ? imagePath.path : imagePath;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the existing list
    List<String> existingList = prefs.getStringList('my_string_list') ?? [];

// print(existingList);
//  print(existingList.length);
    existingList.remove(pathToRemove);

    // Save the updated list back to SharedPreferences
    await prefs.setStringList('my_string_list', existingList);
//   print(existingList);
//  print(existingList.length);
  }

  var imageDataLocal;
  fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    imageDataLocal = prefs.getStringList('my_string_list');
  }

  bool isSelected(dynamic imagePath) {
    // Convert File to String if a File is passed
    //  fetchData();
    //  notifyListeners();
    String pathToCheck = imagePath is File ? imagePath.path : imagePath;
    return _imageData.contains(pathToCheck);
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:political_poster/global/primary_button.dart';
// import 'package:political_poster/route/route.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:stacked/stacked.dart';
// import '../../global/CustomSecondaryButton.dart';
// import '../../route/route.gr.dart';
// import '../../services/download_share_image.dart';
// import '../../services/photo_background_removal.dart';
// import '../../services/user_image_operations.dart';
// import '../../utils/Singletons/prefs_singleton.dart';

// class TemplatesViewModel extends BaseViewModel {
//   final Prefs _prefs = Prefs.instance;

//   int? get selectedID => _prefs.getInt('SelectedID');

//   String _selectedCategory = '';
//   String get selectedCategory => _selectedCategory;
//   set selectedCategory(value) {
//     _selectedCategory = value;
//     notifyListeners();
//   }

//   Color _containerColor = HexColor('#FFFFFF');
//   Color get containerColor => _containerColor;
//   set containerColor(value) {
//     _containerColor = value;
//     notifyListeners();
//   }

//   bool _premiumStatus = false;
//   bool get premiumStatus => _premiumStatus;
//   set premiumStatus(value) {
//     _premiumStatus = value;
//     notifyListeners();
//   }

//   late List<String> _userDetails;
//   List<String> get userDetails => _userDetails;
//   set userDetails(value) {
//     _userDetails = value;
//     notifyListeners();
//   }

//   final PageController _pageController = PageController(initialPage: 0);
//   PageController get pageController => _pageController;

//   Future initialize() async {
//     _selectedCategory = _prefs.getString('CategorySelected') ?? '';
//     await fetchUserDetails(isTestUser: false);
//     setContainerColor();
//     notifyListeners();
//   }

//   Future fetchUserDetails({required bool isTestUser}) async {
//     List<String> _details = [];
//     String userName = _prefs.getString('Name') ?? '';
//     String userTitle = _prefs.getString('Title') ?? '';
//     _details.addAll([userName, userTitle]);
//     userDetails = _details;
//   }

//   Future<Widget> userImage() async {
//     if (selectedID != null) {
//       var userImage = await UserImage().returnSelectedUserImage(selectedID);
//       return Image.file(
//         userImage,
//         fit: BoxFit.contain,
//         width: 260,
//         height: 260,
//         alignment: Alignment.bottomCenter,
//       );
//     } else {
//       return Container(
//           child: SvgPicture.asset(
//         'Asset/SVG/ImagePlaceholder.svg',
//         fit: BoxFit.contain,
//       ));
//     }
//   }

//   void setContainerColor() {
//     switch (_selectedCategory) {
//       case 'BJP':
//         {
//           _containerColor = HexColor('#F97D09');
//           notifyListeners();
//           break;
//         }
//       case 'Congress':
//         {
//           _containerColor = HexColor('#0e813e');
//           notifyListeners();
//           break;
//         }
//       case 'BSP':
//         {
//           _containerColor = HexColor('#2747b6');
//           notifyListeners();
//           break;
//         }
//       case 'SP':
//         {
//           containerColor = HexColor('#0e6c37');
//           notifyListeners();
//           break;
//         }
//       case 'AAP':
//         {
//           containerColor = HexColor('#1073ac');
//           notifyListeners();
//           break;
//         }
//       default:
//         containerColor = HexColor('#F97D09');
//         break;
//     }
//   }

//   Future<XFile?> userImageChange(context) async {
//     ThemeData themeData = Theme.of(context);
//     var image = await UserImage().pickImage(themeData);
//     await UserImage().addUserImage(image);
//     return image;
//   }

//   void conditionalButtonClick(
//       {required ScreenshotController controller,
//       required BuildContext context,
//       required String imageUrl,
//       required bool isTestUser}) async {
//     int? selectedID = _prefs.getInt('SelectedID');
//     if (selectedID == null) {
//       await showPhotoWarning(premiumStatus, context);
//     } else if (premiumStatus) {
//       DownloadShareImage(controller: controller).shareScreenshot();
//     } else {
//       Navigator.push(
//           context,
//           PremiumViewRoute(imageUrl: imageUrl, isTestUser: isTestUser)
//               as Route<Object?>);
//     }
//   }

//   Future showPhotoWarning(premiumStatus, context) {
//     ThemeData themeData = Theme.of(context);
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           content: Container(
//             padding: EdgeInsets.all(20),
//             child: SingleChildScrollView(
//               child: ListBody(
//                 children: [
//                   LottieBuilder.asset(
//                     'Asset/Lottie/alert.json',
//                     height: 84,
//                     width: 84,
//                   ),
//                   Text(
//                     'Please upload photo!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             PrimaryButton(
//               isEnabled: true,
//               isLoading: false,
//               onTap: () async {
//                 await userImageChange(context);
//                 // if(isPhotoAdded){Navigator.pop(context);}
//               },
//               label: 'Upload Photo',
//               color: themeData.colorScheme.primary,
//             )
//           ],
//         );
//       },
//     );
//   }

//   void navigateToNextPage() {
//     if (_pageController.page != null) {
//       _pageController.nextPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
// }
