import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/data/error_response.dart';
import 'package:layali_flutter_app/data/login_response.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/domain/storage_service.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/auth_service.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState.initial());

  final authService =
      getIt.get<RestUnprotectedService>().client.getService<AuthService>();

  void setFirstName(String? value) {
    softReset();
    emit(state.copyWith(firstName: value ?? ''));
  }

  void setLastName(String? value) {
    softReset();
    emit(state.copyWith(lastName: value ?? ''));
  }

  void setPassword(String? value) {
    softReset();
    emit(state.copyWith(password: value ?? ''));
  }

  void setEmail(String? value) {
    softReset();
    emit(state.copyWith(email: value ?? ''));
  }

  void setConfirmPassword(String? value) {
    softReset();
    emit(state.copyWith(confirmPassword: value ?? ''));
  }

  void togglePasswordVisible() {
    softReset();
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisible() {
    softReset();
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  void softReset() {
    emit(state.copyWith(hasError: false, isDone: false, errorMessage: ''));
  }

  Future<void> register() async {
    try {
      softReset();
      emit(state.copyWith(isLoading: true));
      final response = await authService.register(
        state.email,
        state.password,
        state.firstName,
        state.lastName,
        state.confirmPassword,
      );
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
