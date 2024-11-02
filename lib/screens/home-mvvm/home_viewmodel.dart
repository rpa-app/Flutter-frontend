import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:bharatposters0/services/download_share_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:lottie/lottie.dart';

import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../route/route.gr.dart';
import '../../../global/CustomSecondaryButton.dart';
import '../../../services/fetch_content.dart';
import '../../../services/user_db_operations.dart';
import '../../../utils/Singletons/prefs_singleton.dart';

class HomeViewModel extends BaseViewModel implements Initialisable {
  //instance variables:
  int _startingDate = DateTime.now().day;
  int _startingMonth = DateTime.now().month;
  int _startingYear = DateTime.now().year;
  int _emptyCount = 0;

  //getters and setters
  final Prefs _prefs = Prefs.instance;
  Prefs get prefs => _prefs;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  int? get selectedID => _prefs.getInt('SelectedID');

  bool get isSubscribedUser => _prefs.getBool('isSubscribedUser') ?? false;

  bool _showRatingWidget = false;
  bool get showRatingWidget => _showRatingWidget;
  set showRatingWidget(value) {
    _showRatingWidget = value;
    notifyListeners();
  }

  bool _premiumStatus = false;
  bool get premiumStatus => _premiumStatus;
  set premiumStatus(value) {
    _premiumStatus = value;
    notifyListeners();
  }

  List<String> _loadedItems = [];
  List<String> get loadedItems => _loadedItems;

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;

  //initialize logic in init state cycle
  @override
  Future initialise() async {
    await checkForUpdate();
    await getItems();
    // await checkPremiumStatus();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_emptyCount <= 5) {
          getItems();
        }
      }
    });
    // TODO: implement initialise
  }

  //functions for business logic:

  // Future checkPremiumStatus() async {
  //   _premiumStatus = await UserDatabase().checkPremiumStatus() ?? false;
  //   print(_premiumStatus);
  //   print("premium user");
  //   notifyListeners();
  // }

  Future onViewModelReady(context, themeData) async {
    isSubscribedUser
        ? await subscribedUserWarningDialog(context)
        : await nonSubscribedUserWarningDialog(context, themeData);
    await checkIfRatingAsked(context, themeData);
  }

  // Future shareOnWhatsapp() async {
  //   FirebaseFirestore _firestore = await FirebaseFirestore.instance;
  //   DocumentSnapshot documentSnapshot =
  //       await _firestore.collection('Share_Image').doc('ShareImage').get();
  //   String? shareImage = documentSnapshot.get('1');
  //   await DownloadShareImage().nonPremiumShare(imageUrl: shareImage!);
  // }
  // Future<void> shareOnWhatsapp() async {
  //   String imageUrl = "https://images.netaapp.in/Poster-App-Political.jpg";

  //   // Call the nonPremiumShare method with the image URL
  //   await DownloadShareImage().nonPremiumShare(imageUrl: imageUrl);
  // }

  void setDate() {
    if (_startingDate == 1 && _startingMonth != 1) {
      if (_startingMonth == 3 ||
          _startingMonth == 5 ||
          _startingMonth == 7 ||
          _startingMonth == 8 ||
          _startingMonth == 10 ||
          _startingMonth == 12) {
        _startingDate = 30;
        _startingMonth--;
      } else {
        _startingDate = 31;
        _startingMonth--;
      }
    } else if (_startingDate == 1 && _startingMonth == 1) {
      _startingDate = 31;
      _startingMonth = 12;
      _startingYear--;
    } else {
      _startingDate--;
    }
  }

  Future<void> getItems() async {
    if (_showLoadingIndicator) return;

    _showLoadingIndicator = true;
    notifyListeners();

    String? categorySelection = _prefs.getString('CategorySelected');
    List<String> newItems = [];
    List<String> allItems = [];

    bool foundData = false;

    while (!foundData && _emptyCount <= 5) {
      allItems = await FetchContent(
              // date: _startingDate,
              // month: _startingMonth,
              // year: _startingYear,
              selectedCategory: categorySelection)
          .returnContent();

      if (allItems.isNotEmpty) {
        foundData = true;
        newItems =
            allItems.where((item) => !loadedItems.contains(item)).toList();
        loadedItems.addAll(newItems);
        setDate();
        _emptyCount = 0;
      } else {
        foundData = false;
        _emptyCount++;
        setDate();
      }
    }
    _showLoadingIndicator = false;
    notifyListeners();
  }

  Future nonSubscribedUserWarningDialog(context, ThemeData themeData) async {
    int? remainingDays = _prefs.getInt("daysLeft");
    if (remainingDays == null) {
      //do nothing
      // this is when first time the value is null
      // second time remaining days will not be null
      // also the shared preference will remain null unless the user is a premium user
    } else if (remainingDays <= 3) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LottieBuilder.asset(
                      'Asset/Lottie/alert.json',
                      height: 84,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      remainingDays <= 0
                          ? 'आपका प्रीमियम ख़तम हो गया है, पोस्टर शेयर करते रहने के लिए वापस खरीदें'
                          : remainingDays <= 3
                              ? 'आपका प्रीमियम ${remainingDays} दिन में ख़तम होने वाला है'
                              : '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.4,
                          color: Colors.red,
                          fontFamily: 'Mukta'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      remainingDays <= 0
                          ? ''
                          : remainingDays <= 3
                              ? "इसके बाद आप फोटो के साथ पोस्टर शेयर नहीं कर पायेंगे"
                              : '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontFamily: 'Mukta'),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    PrimaryButton(
                      isLoading: false,
                      height: 48,
                      onTap: () async {
                        Navigator.pop(context);
                        AutoRouter.of(context).push(PremiumViewRoute(
                          imageUrl: loadedItems[0],
                        ));
                      },
                      isEnabled: true,
                      label: 'प्रीमियम खरीदें',
                      color: themeData.colorScheme.primary,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomSecondaryButton(
                        leadingIcon: '',
                        buttonColor: Colors.transparent,
                        showIcon: false,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        buttonText: 'बंद करें')
                  ],
                ));
          });
    }
  }

  Future subscribedUserWarningDialog(context) async {
    int? remainingDays = _prefs.getInt("daysLeft");
    bool? isWarningShown = _prefs.getBool('isWarningShown') ?? false;

    if (remainingDays == null) {
      //do nothing
      // this is when first time the value is null
      // second time remaining days will not be null
      // also the shared preference will remain null unless the user is a premium user
    } else if (remainingDays <= 1 && isWarningShown == false) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'प्रीमियम अगले महीने के लिए अपने आप एक्टिवेट हो जाएगा',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.4,
                          color: Colors.black87,
                          fontFamily: 'Mukta'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'आपका ऑटो-पे एक्टिव है, प्रीमियम राशी अपने आप कट जाएगी',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87.withAlpha(150),
                          fontFamily: 'Mukta'),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    PrimaryButton(
                      isLoading: false,
                      onTap: () async {
                        Navigator.pop(context);
                        _prefs.setBool('isWarningShown', true);
                      },
                      isEnabled: true,
                      label: 'ठीक है',
                      color: Colors.grey,
                    ),
                  ],
                ));
          });
    }
  }

  Future checkIfRatingAsked(context, themeData) async {
    String? registerDateString = _prefs.getString('registerDate');
    bool? ratingsAsked = _prefs.getBool('userRatingAsked');
    DateTime registerDate = DateTime.now();

    if (registerDateString == null) {
      _prefs.setString('registerDate', registerDate.toString());
    } else {
      registerDate = DateTime.parse(registerDateString);
      if ((DateTime.now().difference(registerDate).inDays + 1) % 7 == 0 &&
          ratingsAsked == null) {
        await userRatingDialog(context, themeData);
      }
    }
  }

  Future userRatingDialog(context, ThemeData themeData) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    width: MediaQuery.of(context).size.width,
                    child: SvgPicture.asset(
                      'Asset/Icons/cross.svg',
                      height: 36,
                    ),
                  ),
                ),
                LottieBuilder.asset(
                  'Asset/Lottie/PlayStore-rating.json',
                  height: 64,
                  repeat: false,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'अगर आपको हमारा एप्प पसंद आया तो हमें प्ले स्टोर पर 5 स्टार रेटिंग दें',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 24,
                ),
                PrimaryButton(
                  isLoading: false,
                  height: 48,
                  onTap: () async {
                    Navigator.pop(context);
                    final Uri url = Uri.parse(
                        'https://play.google.com/store/apps/details?id=com.bharat.posters');
                    if (!await launchUrl(url,
                        mode: LaunchMode.externalApplication)) {
                      throw Exception('Could not launch $url');
                    }
                    _prefs.setBool('userRatingAsked', true);
                  },
                  label: 'रेटिंग दें',
                  isEnabled: true,
                  color: themeData.colorScheme.primary,
                )
              ],
            ),
          );
        });
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    });
  }
}
