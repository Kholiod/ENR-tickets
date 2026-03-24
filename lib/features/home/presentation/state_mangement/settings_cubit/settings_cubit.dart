// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  /// فتح / قفل الاختيارات
  bool isThemeOpen = false;

  /// الثيم الحالي
  ThemeMode themeMode = ThemeMode.system;

  void toggleTheme() {
    isThemeOpen = !isThemeOpen;
    emit(SettingsChange());
  }

  void changeTheme(ThemeMode mode) {
    themeMode = mode;
    emit(SettingsChange());
  }

  String get themeText {
    switch (themeMode) {
      case ThemeMode.system:
        return "Follow System";
      case ThemeMode.light:
        return "Light Mode";
      case ThemeMode.dark:
        return "Dark Mode";
    }
  }
}