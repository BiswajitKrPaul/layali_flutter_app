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
