// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get email => 'E-Mail-Adresse';

  @override
  String get password => 'Passwort';

  @override
  String get login => 'Einloggen';

  @override
  String get register => 'Registrieren';

  @override
  String get loginSuccess => 'Anmeldung war erfolgreich';

  @override
  String get invalidLogin => 'Ungültige Anmeldedaten. Bitte überprüfen Sie Ihre Eingaben.';
}
