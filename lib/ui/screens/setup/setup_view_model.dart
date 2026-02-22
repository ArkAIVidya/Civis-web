import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:civis_web/data/repository/user_preferences_repository.dart';
import 'package:civis_web/data/repository/progress_repository.dart';
import 'package:civis_web/data/manager/civics_data_manager.dart';
import 'package:civis_web/data/repository/theme_mode_notifier.dart';

part 'setup_view_model.g.dart';

@riverpod
class SetupViewModel extends _$SetupViewModel {
  @override
  SetupUiState build() {
    // Initial load from preferences
    final prefs = ref.watch(userPreferencesRepositoryProvider);
    return SetupUiState(
      zipCode: prefs.zipCode ?? "",
      isTriviaEnabled: prefs.isTriviaEnabled,
      triviaFrequencyMinutes: prefs.triviaFrequencyMinutes,
      isTriviaFilterUnmastered: prefs.isTriviaFilterUnmastered,
      isComplete: prefs.isSetupComplete ?? false,
      themeMode: prefs.themeMode,
    );
  }

  void updateZipCode(String zip) {
    state = state.copyWith(zipCode: zip, error: null);
  }

  Future<void> submitSetup() async {
    final zip = state.zipCode;
    if (zip.length != 5) {
      state = state.copyWith(error: "Invalid Zip Code");
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      final prefs = ref.read(userPreferencesRepositoryProvider);
      final manager = ref.read(civicsDataManagerProvider);

      await prefs.saveZipCode(zip);

      final civicsLiveData = await manager.getCivicsData();
      if (civicsLiveData == null) {
        state = state.copyWith(isLoading: false, error: "Could not load data");
        return;
      }

      final federal = civicsLiveData.federal;
      final stateAbbr = manager.getStateAbbreviation(zip);
      final stateData = stateAbbr != null
          ? civicsLiveData.states[stateAbbr]
          : null;

      await prefs.saveCivicsData(
        president: federal["president_name"] ?? "",
        vp: federal["vp_name"] ?? "",
        governor: stateData?.governorName ?? "",
        senator1: stateData?.senator1Name ?? "",
        senator2: stateData?.senator2Name ?? "",
        rep: "Currently Unavailable",
        speaker: federal["speaker_house_name"] ?? "",
        capital: stateData?.stateCapital ?? "",
        presidentParty: federal["president_party"] ?? "Republican",
        chiefJustice: federal["chief_justice_name"] ?? "John Roberts",
      );

      state = state.copyWith(isLoading: false, isComplete: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> resetAllProgress() async {
    state = state.copyWith(isLoading: true);
    try {
      final progressRepo = ref.read(progressRepositoryProvider);
      await progressRepo.deleteAllProgress("current_user"); // Hardcoded userId
      state = state.copyWith(
        isLoading: false,
        resetMessage: "Progress reset successfully",
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to reset progress: $e",
      );
    }
  }

  void clearResetMessage() {
    state = state.copyWith(resetMessage: null);
  }

  void toggleTrivia(bool enabled) {
    final prefs = ref.read(userPreferencesRepositoryProvider);
    prefs.setTriviaEnabled(enabled);
    state = state.copyWith(isTriviaEnabled: enabled);
    // Background work scheduling would go here (omitted for web or use simple alarms/timers if needed)
  }

  void updateFrequency(int minutes) {
    final prefs = ref.read(userPreferencesRepositoryProvider);
    prefs.setTriviaFrequencyMinutes(minutes);
    state = state.copyWith(triviaFrequencyMinutes: minutes);
  }

  void toggleTriviaFilter(bool enabled) {
    final prefs = ref.read(userPreferencesRepositoryProvider);
    prefs.setTriviaFilterUnmastered(enabled);
    state = state.copyWith(isTriviaFilterUnmastered: enabled);
  }

  void updateThemeMode(ThemeMode mode) {
    ref.read(themeModeProvider.notifier).setMode(mode);
    state = state.copyWith(themeMode: mode);
  }
}

class SetupUiState {
  final String zipCode;
  final bool isLoading;
  final bool isComplete;
  final String? error;
  final String? resetMessage;
  final bool isTriviaEnabled;
  final int triviaFrequencyMinutes;
  final bool isTriviaFilterUnmastered;
  final ThemeMode themeMode;

  SetupUiState({
    this.zipCode = "",
    this.isLoading = false,
    this.isComplete = false,
    this.error,
    this.resetMessage,
    this.isTriviaEnabled = false,
    this.triviaFrequencyMinutes = 1440,
    this.isTriviaFilterUnmastered = false,
    this.themeMode = ThemeMode.system,
  });

  SetupUiState copyWith({
    String? zipCode,
    bool? isLoading,
    bool? isComplete,
    String? error,
    String? resetMessage,
    bool? isTriviaEnabled,
    int? triviaFrequencyMinutes,
    bool? isTriviaFilterUnmastered,
    ThemeMode? themeMode,
  }) {
    return SetupUiState(
      zipCode: zipCode ?? this.zipCode,
      isLoading: isLoading ?? this.isLoading,
      isComplete: isComplete ?? this.isComplete,
      error:
          error, // Allow clearing error by passing null? No, null is ignored. Need explicit clearance if intended.
      // Actually standard copyWith ignores nulls. To clear nullable fields, we need wrapped type or different pattern.
      // For simplicity, if error is passed as null in argument (but not default), it should be cleared?
      // Dart default parameters make this tricky.
      // I'll stick to simple copyWith. If I need to clear, I'll pass null to error and handle it?
      // Wait, `error: error` will use the argument. If the argument is null (because I passed null), it will be null.
      // If I don't pass it, it uses `this.error`? No, Dart named optional parameters default to null if not provided.
      // So `String? error` defaults to null.
      // I need to check if it was provided.
      // I'll assume if I pass it, I want to set it. But I can't distinguish passed null vs default null.
      // I'll just change the signature to accept nullable and use `this.error` as default only if I wanted persistence.
      // But here I want to replace `this.error` with new value.
      // Let's blindly replace.
      resetMessage: resetMessage,
      isTriviaEnabled: isTriviaEnabled ?? this.isTriviaEnabled,
      triviaFrequencyMinutes:
          triviaFrequencyMinutes ?? this.triviaFrequencyMinutes,
      isTriviaFilterUnmastered:
          isTriviaFilterUnmastered ?? this.isTriviaFilterUnmastered,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
