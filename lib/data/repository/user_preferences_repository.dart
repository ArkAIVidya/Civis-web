import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_preferences_repository.g.dart';

@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  // This provider should be overridden in main.dart with helper
  throw UnimplementedError();
}

@riverpod
UserPreferencesRepository userPreferencesRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return UserPreferencesRepository(prefs);
}

class UserPreferencesRepository {
  final SharedPreferences _prefs;

  UserPreferencesRepository(this._prefs);

  static const _zipCodeKey = 'zip_code';
  static const _setupCompleteKey = 'setup_complete';
  static const _triviaEnabledKey = 'trivia_enabled';
  static const _triviaFreqKey = 'trivia_frequency_minutes';
  static const _triviaFilterUnmasteredKey = 'trivia_show_only_unmastered';
  static const _lastTriviaTimeKey = 'last_trivia_time';
  static const _themeModeKey = 'theme_mode';

  String? get zipCode => _prefs.getString(_zipCodeKey);
  bool? get isSetupComplete => _prefs.getBool(_setupCompleteKey);
  bool get isTriviaEnabled => _prefs.getBool(_triviaEnabledKey) ?? false;
  int get triviaFrequencyMinutes => _prefs.getInt(_triviaFreqKey) ?? 1440;
  bool get isTriviaFilterUnmastered =>
      _prefs.getBool(_triviaFilterUnmasteredKey) ?? false;
  int get lastTriviaTime => _prefs.getInt(_lastTriviaTimeKey) ?? 0;

  ThemeMode get themeMode {
    switch (_prefs.getString(_themeModeKey)) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveZipCode(String zip) => _prefs.setString(_zipCodeKey, zip);
  Future<void> setSetupComplete(bool complete) =>
      _prefs.setBool(_setupCompleteKey, complete);
  Future<void> setTriviaEnabled(bool enabled) =>
      _prefs.setBool(_triviaEnabledKey, enabled);
  Future<void> setTriviaFrequencyMinutes(int minutes) =>
      _prefs.setInt(_triviaFreqKey, minutes);
  Future<void> setTriviaFilterUnmastered(bool enabled) =>
      _prefs.setBool(_triviaFilterUnmasteredKey, enabled);
  Future<void> setLastTriviaTime(int timestamp) =>
      _prefs.setInt(_lastTriviaTimeKey, timestamp);
  Future<void> setThemeMode(ThemeMode mode) =>
      _prefs.setString(_themeModeKey, mode.name);

  // Helper to save multiple fields
  Future<void> saveCivicsData({
    required String president,
    required String vp,
    required String governor,
    required String senator1,
    required String senator2,
    required String rep,
    required String speaker,
    required String capital,
    required String presidentParty,
    required String chiefJustice,
  }) async {
    await _prefs.setString('president_name', president);
    await _prefs.setString('vp_name', vp);
    await _prefs.setString('governor_name', governor);
    await _prefs.setString('senator_1_name', senator1);
    await _prefs.setString('senator_2_name', senator2);
    await _prefs.setString('representative_name', rep);
    await _prefs.setString('speaker_house_name', speaker);
    await _prefs.setString('state_capital', capital);
    await _prefs.setString('president_party', presidentParty);
    await _prefs.setString('chief_justice_name', chiefJustice);
    await setSetupComplete(true);
  }

  String? getOfficial(String key) => _prefs.getString(key);
}
