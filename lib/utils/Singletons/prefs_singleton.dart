import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _prefs;
  static Prefs? _instance;

  Prefs._(); // private constructor

  static Prefs get instance {
    _instance ??= Prefs._();
    return _instance!;
  }

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  //sets:
  Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  Future<bool> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  //gets
  bool? getBool(String key) => _prefs.getBool(key);

  String? getString(String key) => _prefs.getString(key);

  double? getDouble(String key) => _prefs.getDouble(key);

  int? getInt(String key) => _prefs.getInt(key);

  List<String>? getStringList(String key) => _prefs.getStringList(key);
}
