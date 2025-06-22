import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:layali_flutter_app/l10n/app_localizations.dart';

extension L10nUtils on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}

extension ValidatorBuilders on ValidationBuilder {
  ValidationBuilder confirmPassword(
    String confirmPassword,
    BuildContext context,
  ) => add((value) {
    if (confirmPassword != value) {
      return context.localizations.passwordDoesNotMatch;
    }
    return null;
  });
}

class AppUtils {
  static bool hasTextOverflow(
    String text,
    TextStyle? style,
    double? textScaleFactor, {
    double minWidth = 0,
    double maxWidth = double.infinity,
    int maxLines = 2,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      textScaler: TextScaler.linear(textScaleFactor ?? 1.0),
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }
}
