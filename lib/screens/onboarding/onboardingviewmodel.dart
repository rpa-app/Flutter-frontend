import 'dart:convert';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/global/403code.dart';
import 'package:bharatposters0/screens/party-list/party_list_view.dart';
import 'package:bharatposters0/route/route.gr.dart';
import 'package:bharatposters0/utils/Singletons/prefs_singleton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class OnboardingDetailsViewModel extends ChangeNotifier {
  final Prefs prefs = Prefs.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _numberController = TextEditingController();
  TextEditingController get numberController => _numberController;

  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  bool _isEnabled = false;
  bool get isEnabled => _isEnabled;

  // Future<void> generateAndSaveDeviceId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String deviceId = Uuid().v4();
  //   prefs.setString('deviceId', deviceId);
  //   print("deviceId: $deviceId");
  // }
  String generateRandomDeviceId() {
    Random random = Random();
    int randomNumber = random.nextInt(999999999); // Adjust the range as needed
    return randomNumber.toString();
  }

  void clickEnabled() {
    if (numberController.text != '' && nameController.text != '') {
      _isEnabled = true;
      notifyListeners();
    } else {
      _isEnabled = false;
      notifyListeners();
    }
  }

  Future<String> generateRandomDeviceid() async {
    final prefs = await SharedPreferences.getInstance();
    String deviceId = Uuid().v4();
    prefs.setString('deviceId', deviceId);
    print("Generated deviceId: $deviceId");
    return deviceId;
  }

  Future<void> onSaved({
    required bool isTestUser,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();

    String deviceId = prefs.getString('deviceId') ?? generateRandomDeviceId();
    prefs.setString('deviceId', deviceId);
    print("Retrieved deviceId: $deviceId");

    final url =
        Uri.parse('https://bharatposters.rpaventuresllc.com/updateUser');
    // final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? userId = prefs.getString('userId');
    // print("Retrieved deviceId: $token");
    // print("Retrieved deviceId: $userId");

    if (token == null || userId == null) {
      // Handle case when token or userId is null
      print('Token or userId not found in SharedPreferences');
      _isLoading = false;
      notifyListeners();
      return;
    }

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'token': token,
      'appUserId': userId,
      // "DEVICE_ID": deviceId,
      // "CLIENT_VERSION": "26",
      // "CLIENT_TYPE": "ANDROID",
      // "CLIENT_VERSION_CODE": "79",
      // "package-name": "com.rpa.election"
    };

    final cleanedName =
        _nameController.text.trim().replaceAll(RegExp(r'[^\x00-\x7F]'), '');
    final cleanedNumber =
        _numberController.text.trim().replaceAll(RegExp(r'[^\x00-\x7F]'), '');
    final cleanedDescription =
        _titleController.text.trim().replaceAll(RegExp(r'[^\x00-\x7F]'), '');

    final body = jsonEncode(<String, dynamic>{
      'phone_number': _numberController.text,
      'user_name': cleanedName,
      'position_in_party': cleanedDescription,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // AutoRouter.of(context).push(PartyListViewRoute());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PartyListView()));
        // Handle success
        print('User details updated successfully');
        setPreferences();
        print(response.statusCode);
        print(response.body);
        // Navigate to the next screen or perform any other action
        // } else if (response.statusCode == 403) {
        // DialogBox.showSessionTimeoutDialog(context);
      } else {
        // Handle failure
        // AutoRouter.of(context).push(PartyListViewRoute());
        // MaterialPageRoute(builder: (context) => const PartyListView());
        print('Failed to update user details');
        print(response.body);
        print(response.statusCode);
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? userId = prefs.getString('userId');

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'token': token ?? '',
      'appUserId': userId ?? '',
      // "DEVICE_ID": deviceId,
      // "CLIENT_VERSION": "22",
      // "CLIENT_TYPE": "ANDROID",
      // "CLIENT_VERSION_CODE": "79",
      // "package-name": "com.rpa.election"
    };

    final url =
        Uri.parse('https://bharatposters.rpaventuresllc.com/getUserInfo');
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        print(userData);
        final name = userData['user_name'];
        final title = userData['position_in_party'];
        final number = userData['phone_number'];
        final email = userData['email_id'];
        print('Number from API: $number');

        _nameController.text = name ?? '';
        _titleController.text = title ?? '';
        _numberController.text = number ?? '';
        print("Name: $name, Title: $title, Number: $number, Email: $email");
        print("fetched details");
        //  setPreferences();
        prefs.setString('email', email);
        prefs.setString('number', number);
        prefs.setString('name', name);
        clickEnabled();
        notifyListeners();
      } else {
        print(response.body);
        print('Failed to fetch user details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  void setPreferences() {
    prefs.setBool('isOnboarded', true);
    prefs.setString('Name', _nameController.text);
    prefs.setString('Title', _titleController.text);
    prefs.setString('number', _numberController.text);
    prefs.setString('registerDate', DateTime.now().toString());
  }
}
