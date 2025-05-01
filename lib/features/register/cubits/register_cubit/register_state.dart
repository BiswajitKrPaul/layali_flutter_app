part of 'register_cubit.dart';

@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool isDone,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isPasswordVisible,
    @Default('') String confirmPassword,
    @Default(false) bool isConfirmPasswordVisible,
  }) = _RegisterState;

  factory RegisterState.initial() => const RegisterState();
}
