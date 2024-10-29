import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../services/user_db_operations.dart';
import '../../../utils/Singletons/prefs_singleton.dart';
import 'package:http/http.dart' as http;

class EditProfileViewModel extends BaseViewModel {
  //instances
  final Prefs _prefs = Prefs.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //getters and setters
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  final TextEditingController _numberController = TextEditingController();
  TextEditingController get numberController => _numberController;

  //functions required for business logic
  // Future saveAndExit() async {
  //   UserDatabase(
  //       userPhone: int.parse(_numberController.text),
  //       userName: _nameController.text,
  //       userTitle: _titleController.text).createUserDatabase();
  //   await setSharedPreferences(
  //       _nameController.text,
  //       _titleController.text,
  //       int.parse(_numberController.text));
  // }
  Future<void> onSaved({
    bool isTestUser = false,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final url =
        Uri.parse('https://bharatposters.rpaventuresllc.com/updateUser');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? userId = prefs.getString('userId');

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
      'appUserIdd': userId,
    };

    final cleanedName =
        _nameController.text.replaceAll(RegExp(r'[^\x00-\x7F]'), '');
    final cleanedNumber =
        _numberController.text.replaceAll(RegExp(r'[^\x00-\x7F]'), '');
    final cleanedDescription =
        _titleController.text.replaceAll(RegExp(r'[^\x00-\x7F]'), '');

    final body = jsonEncode(<String, dynamic>{
      'number': cleanedNumber,
      'name': cleanedName,
      'description': cleanedDescription,
    });
    print(cleanedNumber + cleanedName + cleanedDescription);

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // AutoRouter.of(context).push(PartyListViewRoute());
        // Handle success
        print('User details updated successfully');
        setSharedPreferences(
            cleanedName, cleanedDescription, int.parse(cleanedNumber));
        print(response.body);
        print(cleanedName + cleanedNumber + cleanedDescription);
        print(_prefs.getString('Name'));
        print(_prefs.getString('Title'));
        // Navigate to the next screen or perform any other action
      } else {
        // Handle failure
        // AutoRouter.of(context).push(PartyListViewRoute());
        print('Failed to update user details');
        print(response.statusCode);
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future setSharedPreferences(String name, String title, int number) async {
    await _prefs.setString('Name', _nameController.text);
    await _prefs.setString('Title', _titleController.text);
    await _prefs.setString('number', _numberController.text);
  }
}
