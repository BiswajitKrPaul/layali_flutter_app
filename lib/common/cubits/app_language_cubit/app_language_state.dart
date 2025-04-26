part of 'app_language_cubit.dart';

@freezed
abstract class AppLanguageState with _$AppLanguageState {
  const factory AppLanguageState({
    @Default("de") String index,
    @Default('en') String language,
    @Default([]) List<Locale> supportedLocales,
  }) = _AppLanguageState;

  factory AppLanguageState.initial() => const AppLanguageState();
}
