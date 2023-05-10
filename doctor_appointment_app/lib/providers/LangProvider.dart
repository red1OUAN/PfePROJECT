import 'package:hive_flutter/hive_flutter.dart';

import '../utils/appLanguages.dart';
import '../utils/hiveBoxKeys.dart';

class SettingsRepository {
  static String getCurrentLanguageCode() {
    final currentLanguage =
        Hive.box(currentLanguageCodeKey).get(currentLanguageCodeKey) ??
            defaultLanguageCode;
    return currentLanguage ?? defaultLanguageCode;
  }
   static String setCurrentLanguageCode(currentLanguage) {
    final currentLanguage =
        Hive.box(currentLanguageCodeKey).get(currentLanguageCodeKey) ??
            defaultLanguageCode;
    return currentLanguage ?? defaultLanguageCode;
  }
}
