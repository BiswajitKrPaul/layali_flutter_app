import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/app_router.dart';
import 'package:layali_flutter_app/common/utils/mixin_utils.dart';
import 'package:layali_flutter_app/data/login_response.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/auth_service.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@singleton
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  final authService = getIt.get<RestService>().client.getService<AuthService>();

  void setEmail(String? value) {
    softReset();
    emit(state.copyWith(email: value ?? ""));
  }

  void softReset() {
    emit(state.copyWith(hasError: false, errorMessage: "", isDone: false));
  }

  void setPassword(String? value) {
    softReset();
    emit(state.copyWith(password: value ?? ""));
  }

  Future<void> login() async {
    softReset();
    emit(state.copyWith(isLoading: true));
    final response = await authService.login(state.email, state.password);
    try {
      if (response.isSuccessful) {
        emit(state.copyWith(isLoading: false, isDone: true));
        debugPrint(LoginResponse.fromJson(response.body!).toString());
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage:
                getIt
                    .get<AppRouter>()
                    .navigatorKey
                    .currentContext!
                    .localizations
                    .invalidLogin,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage:
              getIt
                  .get<AppRouter>()
                  .navigatorKey
                  .currentContext!
                  .localizations
                  .invalidLogin,
        ),
      );
    }
  }
}
