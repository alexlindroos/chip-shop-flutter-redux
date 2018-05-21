import 'package:flutter/material.dart';
import 'dart:async';

class ChipShopLocalizations {

  static ChipShopLocalizations of(BuildContext context) {
    return Localizations.of<ChipShopLocalizations>(
      context,
      ChipShopLocalizations
    );
  }

  String get appTitle => "Chipz";
}

class ChipShopLocalizationsDelegate extends LocalizationsDelegate<ChipShopLocalizations> {

  @override
  bool isSupported(Locale locale) {
    if (locale.languageCode.toLowerCase().contains("en")) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<ChipShopLocalizations> load(Locale locale) => new Future(() => new ChipShopLocalizations());

  @override
  bool shouldReload(LocalizationsDelegate<ChipShopLocalizations> old) => false;
}