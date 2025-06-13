import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:layali_flutter_app/app_router.dart';
import 'package:layali_flutter_app/common/cubits/app_language_cubit/app_language_cubit.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/common/cubits/location_service_cubit/location_service_cubit.dart';
import 'package:layali_flutter_app/domain/storage_service.dart';
import 'package:layali_flutter_app/features/home/cubits/listing_property_cubit/listing_propety_cubit.dart';
import 'package:layali_flutter_app/features/search_listing/cubits/place_search_cubit/place_search_cubit.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/l10n/app_localizations.dart';
import 'package:layali_flutter_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final authToken = await getIt.get<StorageService>().getToken() ?? '';
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return getIt.get<AppLanguageCubit>()..getAllLanguages();
          },
        ),
        BlocProvider(
          lazy: false,
          create:
              (context) =>
                  getIt.get<AuthenticationCubit>()..setToken(authToken),
        ),
        BlocProvider(
          create: (context) {
            return getIt.get<LocationServiceCubit>();
          },
        ),
        BlocProvider(
          create: (context) {
            return ListingPropetyCubit();
          },
        ),
        BlocProvider(create: (context) => PlaceSearchCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: getIt.get<AppRouter>().config(),
      locale: Locale.fromSubtags(
        languageCode: context.watch<AppLanguageCubit>().state.index,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
