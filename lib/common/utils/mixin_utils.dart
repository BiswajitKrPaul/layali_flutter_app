import 'package:flutter/material.dart';
import 'package:layali_flutter_app/l10n/app_localizations.dart';

extension L10nUtils on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
