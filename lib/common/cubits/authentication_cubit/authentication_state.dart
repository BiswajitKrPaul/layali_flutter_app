part of 'authentication_cubit.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({User? user, @Default('') String token}) =
      _AuthenticationState;
  const AuthenticationState._();

  factory AuthenticationState.initial() => const AuthenticationState();

  bool get isAuthenticated => token.isNotEmpty;
}
