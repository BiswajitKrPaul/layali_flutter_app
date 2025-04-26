part of 'login_cubit.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    required String email,
    required String password,
    @Default(false) bool isLoading,
    @Default("") String errorMessage,
    @Default(false) bool isDone,
    @Default(false) bool hasError,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(email: "", password: "");
}
