import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:layali_flutter_app/app_router.dart';
import 'package:layali_flutter_app/common/cubits/app_language_cubit/app_language_cubit.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/l10n/app_localizations.dart';

import 'theme.dart';
import 'util.dart';

void main() {
  configureDependencies();
  runApp(
    BlocProvider(
      create: (context) => getIt.get<AppLanguageCubit>()..getAllLanguages(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "AR One Sans", "ABeeZee");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: getIt.get<AppRouter>().config(),
      locale: Locale.fromSubtags(
        languageCode: context.watch<AppLanguageCubit>().state.index,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
