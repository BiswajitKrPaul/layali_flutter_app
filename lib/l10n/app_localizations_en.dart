// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get loginSuccess => 'Login Successful';

  @override
  String get invalidLogin => 'Invalid Login Credentials';

  @override
  String get explore => 'Explore';

  @override
  String get wishlist => 'Wishlist';

  @override
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get trips => 'Trips';

  @override
  String get inbox => 'Inbox';

  @override
  String get emailOrPasswordEmpty => 'Email or Password is empty';
}
