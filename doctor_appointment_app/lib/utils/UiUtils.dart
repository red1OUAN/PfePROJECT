import 'package:flutter/material.dart';

import '../styles/widgets/errorMessageOverlayContainer.dart';
import 'appLocalization.dart';

class UiUtils {
  static Future<void> showCustomSnackBar(
      {required BuildContext context,
      required String errorMessage,
      required Color backgroundColor}) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => ErrorMessageOverlayContainer(
        backgroundColor: backgroundColor,
        errorMessage: errorMessage,
      ),
    );

    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(milliseconds: 3000));
    overlayEntry.remove();
  }

  static Locale getLocaleFromLanguageCode(String languageCode) {
    List<String> result = languageCode.split("-");
    return result.length == 1
        ? Locale(result.first)
        : Locale(result.first, result.last);
  }

  static String getTranslatedLabel(BuildContext context, String labelKey) {
    return (AppLocalization.of(context)!.getTranslatedValues(labelKey) ??
            labelKey)
        .trim();
  }
}
