import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppLocalizations {
  final Locale? locale;

  AppLocalizations({this.locale});
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  static  LocalizationsDelegate<AppLocalizations> delegate  = _AppLocalizationDelegate() ;

  late Map<String, String> _localizedstring;
  Future loadJsonLanguage() async {
    String jsonString = await rootBundle.loadString("lib/assets/lang/${locale!.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedstring = jsonMap.map((key, value) {
     return MapEntry(key, value.toString());
    });
  }
  String translate(String key )=> _localizedstring[key]??"";
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations>{
  @override
  bool isSupported(Locale locale) {
  // ignore: iterable_contains_unrelated_type
  return['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale)async {
AppLocalizations localizations = AppLocalizations(locale: locale) ;
await localizations.loadJsonLanguage() ;
return localizations ;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
     return false  ; 
  }

  
}
extension TranslateExtension on String {
  String tr(BuildContext context){
    return AppLocalizations.of(context)!.translate(this) ;
  }
}