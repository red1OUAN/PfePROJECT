import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/appLanguages.dart';
import '../utils/hiveBoxKeys.dart';

class LangProvider with ChangeNotifier {
  String  getCurrentLanguageCode() {
    final currentLanguage =
        Hive.box(currentLanguageCodeKey).get(currentLanguageCodeKey) ??
            defaultLanguageCode;
    return currentLanguage ?? defaultLanguageCode;
  }
 

  void setCurrentLanguageCode(currentLanguage) {
    Hive.box(currentLanguageCodeKey)
        .put(currentLanguageCodeKey, currentLanguage);
    notifyListeners();
  }
}
