import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/data/error_response.dart';
import 'package:layali_flutter_app/data/login_response.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/domain/storage_service.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/auth_service.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  final authService =
      getIt.get<RestUnprotectedService>().client.getService<AuthService>();

  void setEmail(String? value) {
    softReset();
    emit(state.copyWith(email: value ?? ''));
  }

  void softReset() {
    emit(state.copyWith(hasError: false, errorMessage: '', isDone: false));
  }

  void setPassword(String? value) {
    softReset();
    emit(state.copyWith(password: value ?? ''));
  }

  void togglePasswordVisible() {
    softReset();
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> login() async {
    softReset();
    emit(state.copyWith(isLoading: true));
    try {
      final response = await authService.login(state.email, state.password);
      if (response.isSuccessful) {
        final loginResponse = LoginResponse.fromJson(response.body!);
        await getIt.get<StorageService>().saveToken(loginResponse.accessToken);
        getIt.get<AuthenticationCubit>().setToken(loginResponse.accessToken);
        emit(state.copyWith(isLoading: false, isDone: true));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage:
                ErrorResponse.fromJson(
                  (response.error as Map<String, dynamic>?) ?? {},
                ).detail,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
