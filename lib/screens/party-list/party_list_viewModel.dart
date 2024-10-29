import 'dart:convert';
import 'package:bharatposters0/utils/Singletons/prefs_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class PartyListViewModel extends BaseViewModel {
  final Prefs _prefs = Prefs.instance;

  // Fetch state information from the config
  Future<List<Map<String, String>>> fetchStateInfos() async {
    try {
      String? configJson = _prefs.getString('configResponse');
      if (configJson != null) {
        Map<String, dynamic> config =
            jsonDecode(utf8.decode(configJson.codeUnits));
        List<dynamic> stateInfos = config['statePartyInfo'];
        List<Map<String, String>> stateInfoList = stateInfos.map((info) {
          return {
            'state': info['state'] as String,
            'name': info['referedName'] as String,
            'regionalName': info['regionalName'] as String,
          };
        }).toList();
        return stateInfoList;
      }
      return [];
    } catch (e) {
      print('Error fetching state infos: $e');
      return [];
    }
  }

  // Fetch party information for a selected state
  Future<List<Map<String, String>>> getSelectedStateInfo(String state) async {
    try {
      String? configJson = _prefs.getString('configResponse');
      if (configJson != null) {
        Map<String, dynamic> config = jsonDecode(configJson);

        // Locate state in 'statePartyInfo'
        List<dynamic> stateInfos = config['statePartyInfo'];
        Map<String, dynamic>? selectedStateInfo = stateInfos.firstWhere(
          (info) => info['state'] == state,
          orElse: () => null,
        );

        // Extract and return party information if state is found
        if (selectedStateInfo != null) {
          List<dynamic> parties = selectedStateInfo['partyInfo'];
          List<Map<String, String>> partyInfoList = parties.map((party) {
            return {
              'partyName': party['party'] as String,
              'partyLogo': party['logo'] as String,
              'partyId': party['referedName'] as String,
            };
          }).toList();
          return partyInfoList;
        } else {
          print('State not found in any list');
        }
      }
      return [];
    } catch (e) {
      print('Error fetching selected state info: $e');
      return [];
    }
  }

  // Save user selection for state and party
  // Future<void> saveUserSelection(String state, String partyName) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? token = prefs.getString('token');
  //   final String? userId = prefs.getString('userId');
  //   final String deviceId = prefs.getString('deviceId') ?? '';
  //   final url = 'https://backend.polimart.in/polimart/user/v1/user';
  //   final headers = <String, String>{
  //     'Content-Type': 'application/json',
  //     'TOKEN': token ?? '',
  //     'app-user-id': userId ?? '',
  //     'DEVICE_ID': deviceId,
  //     'CLIENT_VERSION': '22',
  //     'CLIENT_TYPE': 'ANDROID',
  //     'CLIENT_VERSION_CODE': '77'
  //   };

  //   try {
  //     final response = await http.put(
  //       Uri.parse(url),
  //       headers: headers,
  //       body: jsonEncode({'state': state, 'party': partyName}),
  //     );

  //     if (response.statusCode == 200) {
  //       print(
  //           'Successfully updated user selection: State: $state, Party: $partyName');
  //     } else {
  //       print(
  //           'Failed to save user selection. Status code: ${response.statusCode}');
  //       throw Exception('Failed to save user selection');
  //     }
  //   } catch (e) {
  //     print('Error saving user selection: $e');
  //     throw Exception('Error saving user selection: $e');
  //   }
  // }

  // Save selected party and logo
  Future<void> setParty(String selectedParty, String partyLogo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedParty', selectedParty);
    await prefs.setString("selectedPartyLogo", partyLogo);
    print('Selected Party: $selectedParty');
  }

  // Save category selection in SharedPreferences
  void setSharedPrefs(String selectedCategory) async {
    _prefs.setString('CategorySelected', selectedCategory);
    print("selectedCategory: $selectedCategory");
  }
}
