import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/l10n/app_localizations.dart';

part 'app_language_cubit.freezed.dart';
part 'app_language_state.dart';

@singleton
class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(AppLanguageState());

  void getAllLanguages() {
    emit(
      state.copyWith(
        supportedLocales: AppLocalizations.supportedLocales,
        index: AppLocalizations.supportedLocales.first.languageCode,
      ),
    );
  }

  void changeLanguage(String index) {
    emit(state.copyWith(index: index));
  }
}
