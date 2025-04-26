import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart' show AutoRouteWrapper;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/common/cubits/app_language_cubit/app_language_cubit.dart';
import 'package:layali_flutter_app/common/utils/mixin_utils.dart';
import 'package:layali_flutter_app/features/login/cubits/login_cubit/login_cubit.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:recase/recase.dart';

@RoutePage()
class LoginPage extends StatelessWidget implements AutoRouteWrapper {
  const LoginPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<LoginCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.isDone) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.localizations.loginSuccess)),
              );
            } else if (state.hasError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, loginState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  onChanged: context.read<LoginCubit>().setEmail,
                  decoration: InputDecoration(
                    labelText: context.localizations.email,
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  onChanged: context.read<LoginCubit>().setPassword,
                  decoration: InputDecoration(
                    labelText: context.localizations.password.titleCase,
                    border: const OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    FilledButton(
                      onPressed: () async {
                        await context.read<LoginCubit>().login();
                      },
                      child: Text(context.localizations.login.titleCase),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(context.localizations.register.titleCase),
                    ),
                  ],
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
                          state.supportedLocales
                              .mapIndexed<DropdownMenuItem<String>>((i, e) {
                                return DropdownMenuItem(
                                  value: e.languageCode,
                                  child: Text(e.languageCode),
                                );
                              })
                              .toList(),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
