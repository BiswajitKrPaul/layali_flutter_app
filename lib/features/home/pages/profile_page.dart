import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/common/cubits/app_language_cubit/app_language_cubit.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/common/utils/mixin_utils.dart';
import 'package:layali_flutter_app/injection.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton(
          onPressed: () {
            getIt.get<AuthenticationCubit>().logout();
          },
          child: Text(context.localizations.logout),
        ),
        BlocBuilder<AppLanguageCubit, AppLanguageState>(
          builder: (context, state) {
            return DropdownButton<String>(
              value: state.index,
              elevation: 16,
              onChanged: (String? value) {
                context.read<AppLanguageCubit>().changeLanguage(value!);
              },
              items:
                  state.supportedLocales.mapIndexed<DropdownMenuItem<String>>((
                    i,
                    e,
                  ) {
                    return DropdownMenuItem(
                      value: e.languageCode,
                      child: Text(e.languageCode),
                    );
                  }).toList(),
            );
          },
        ),
      ],
    );
  }
}
