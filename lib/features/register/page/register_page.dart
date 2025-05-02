import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/register/cubits/register_cubit/register_cubit.dart';
import 'package:layali_flutter_app/gen/assets.gen.dart';

final _formKey = GlobalKey<FormState>();

@RoutePage()
class RegisterPage extends StatelessWidget implements AutoRouteWrapper {
  const RegisterPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => RegisterCubit(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    ValidationBuilder.setLocale(context.localizations.localeName);
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.longestSide,
            ),
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state.isDone) {
                  context.router.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.localizations.registerSuccess),
                    ),
                  );
                } else if (state.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage.isEmpty
                            ? context.localizations.registerFailed
                            : state.errorMessage,
                      ),
                    ),
                  );
                }
              },
              builder: (context, registerState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    SizedBox(height: 250, child: Assets.images.logo.image()),
                    TextFormField(
                      onChanged: context.read<RegisterCubit>().setFirstName,
                      keyboardType: TextInputType.name,
                      decoration: _textFormFieldDecoration(
                        context.localizations.firstName,
                      ),
                      validator:
                          ValidationBuilder().maxLength(50).required().build(),
                    ), // First Name
                    TextFormField(
                      keyboardType: TextInputType.name,
                      onChanged: context.read<RegisterCubit>().setLastName,
                      decoration: _textFormFieldDecoration(
                        context.localizations.lastName,
                      ),
                      validator:
                          ValidationBuilder().maxLength(50).required().build(),
                    ), // Last Name
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: context.read<RegisterCubit>().setEmail,
                      decoration: _textFormFieldDecoration(
                        context.localizations.email,
                      ),
                      validator: ValidationBuilder().email().required().build(),
                    ), // Email
                    TextFormField(
                      obscureText: !registerState.isPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: context.read<RegisterCubit>().setPassword,
                      decoration: _textFormFieldDecoration(
                        context.localizations.password,
                        suffix: IconButton(
                          icon: Icon(
                            registerState.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed:
                              context
                                  .read<RegisterCubit>()
                                  .togglePasswordVisible,
                        ),
                      ),
                      validator:
                          ValidationBuilder().minLength(8).required().build(),
                    ), // Password
                    TextFormField(
                      obscureText: !registerState.isConfirmPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged:
                          context.read<RegisterCubit>().setConfirmPassword,
                      decoration: _textFormFieldDecoration(
                        context.localizations.confirmPassword,
                        suffix: IconButton(
                          icon: Icon(
                            registerState.isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed:
                              context
                                  .read<RegisterCubit>()
                                  .toggleConfirmPasswordVisible,
                        ),
                      ),
                      validator:
                          ValidationBuilder()
                              .minLength(8)
                              .required()
                              .confirmPassword(registerState.password, context)
                              .build(),
                    ), // Confirm Password
                    Visibility(
                      visible: registerState.isLoading,
                      child: const CircularProgressIndicator(),
                    ),
                    Visibility(
                      visible: !registerState.isLoading,
                      child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await context.read<RegisterCubit>().register();
                          }
                        },
                        child: Text(context.localizations.register),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _textFormFieldDecoration(String labelText, {Widget? suffix}) {
    return InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
      suffixIcon: suffix,
    );
  }
}
