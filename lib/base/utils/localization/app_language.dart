import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale? _appLocale = const Locale('en');

  Locale get appLocal => _appLocale ?? const Locale('en');

  AppLanguage(){
    fetchLocale();
  }
  Future<void> fetchLocale() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('en');
      notifyListeners();

    }
    _appLocale = Locale(prefs.getString('language_code')?? 'en');
    notifyListeners();

  }


  Future changeLanguage(Locale type) async {
    final prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale('en')) {
      _appLocale = const Locale('en');
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', '');
    }else {
      _appLocale = const Locale('ar');
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
    }
    notifyListeners();
  }
}