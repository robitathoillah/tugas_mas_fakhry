import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_data.dart';

class PrefService {
  PrefService._(this._prefs);
  final SharedPreferences _prefs;

  static const _kOpenCount = 'open_count';
  static const _kDarkMode = 'is_dark_mode';
  static const _kProfileData = 'profile_data';

  static Future<PrefService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefService._(prefs);
  }

  int get openCount => _prefs.getInt(_kOpenCount) ?? 0;
  Future<void> increaseOpenCount() =>
      _prefs.setInt(_kOpenCount, openCount + 1);

  bool get isDarkMode => _prefs.getBool(_kDarkMode) ?? false;
  Future<void> setDarkMode(bool value) => _prefs.setBool(_kDarkMode, value);

  // ---------- Profil JSON ----------
  ProfileData get profile {
    final jsonString = _prefs.getString(_kProfileData);
    if (jsonString == null) return ProfileData.defaults;
    try {
      return ProfileData.fromJson(jsonDecode(jsonString));
    } catch (_) {
      return ProfileData.defaults;
    }
  }

  Future<void> saveProfile(ProfileData profile) =>
      _prefs.setString(_kProfileData, jsonEncode(profile.toJson()));
}