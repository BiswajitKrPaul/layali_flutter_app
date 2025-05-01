import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart' show AutoRouteWrapper, AutoRouterX;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/common/cubits/app_language_cubit/app_language_cubit.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/login/cubits/login_cubit/login_cubit.dart';
import 'package:layali_flutter_app/gen/assets.gen.dart';
import 'package:recase/recase.dart';

@RoutePage()
class LoginPage extends StatelessWidget implements AutoRouteWrapper {
  const LoginPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => LoginCubit(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.isDone) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.localizations.loginSuccess)),
            );
            context.router.replaceAll(const [HomePageRoute()]);
          } else if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage.isEmpty
                      ? context.localizations.invalidLogin
                      : state.errorMessage,
                ),
              ),
            );
          }
        },
        builder: (context, loginState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.longestSide,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  SizedBox(
                    height: 250,
                    child: SvgPicture.asset(Assets.svg.login),
                  ),
                  TextField(
                    onChanged: context.read<LoginCubit>().setEmail,
                    decoration: InputDecoration(
                      labelText: context.localizations.email,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    onChanged: context.read<LoginCubit>().setPassword,
                    decoration: InputDecoration(
                      labelText: context.localizations.password.titleCase,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginState.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          context.read<LoginCubit>().togglePasswordVisible();
                        },
                      ),
                    ),
                    obscureText: !loginState.isPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  Visibility(
                    visible: !loginState.isLoading,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 16,
                      children: [
                        FilledButton(
                          onPressed: () async {
                            if (loginState.isFormValid) {
                              await context.read<LoginCubit>().login();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.localizations.emailOrPasswordEmpty,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(context.localizations.login.titleCase),
                        ),
                        TextButton(
                          onPressed: () {
                            context.router.push(const RegisterPageRoute());
                          },
                          child: Text(context.localizations.register.titleCase),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: loginState.isLoading,
                    child: const CircularProgressIndicator(),
                  ),
                  BlocBuilder<AppLanguageCubit, AppLanguageState>(
                    builder: (context, state) {
                      return DropdownButton<String>(
                        value: state.index,
                        elevation: 16,
                        onChanged: (String? value) {
                          context.read<AppLanguageCubit>().changeLanguage(
                            value!,
                          );
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
              ),
            ),
          );
        },
      ),
    );
  }
}
