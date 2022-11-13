import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('en');

  Locale get appLocal => _appLocale;
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(AppConstants.countryCode) == null) {
      _appLocale = const Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString(AppConstants.languageCode)!);
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("ar")) {
      _appLocale = const Locale("ar");
      await prefs.setString(AppConstants.languageCode, 'ar');
      await prefs.setString(AppConstants.countryCode, '');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString(AppConstants.languageCode, 'en');
      await prefs.setString(AppConstants.countryCode, '');
    }
    notifyListeners();
  }
}
