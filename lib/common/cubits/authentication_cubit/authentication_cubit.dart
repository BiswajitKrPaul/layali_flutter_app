import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/data/user.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/domain/storage_service.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/user_service.dart';

part 'authentication_cubit.freezed.dart';
part 'authentication_state.dart';

@lazySingleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState.initial());

  final _restClient =
      getIt.get<RestProtectedService>().client.getService<UserService>();

  void setToken(String token) {
    emit(state.copyWith(token: token));
    getAuthentication();
  }

  Future<void> getAuthentication() async {
    try {
      if (state.token.isNotEmpty) {
        final userResponse = await _restClient.getProfile();
        if (userResponse.isSuccessful) {
          final user = User.fromJson(userResponse.body!);
          emit(state.copyWith(user: user));
        } else {
          emit(AuthenticationState.initial());
          await logout();
        }
      }
    } catch (e) {
      emit(AuthenticationState.initial());
      await logout();
    }
  }

  Future<void> logout() async {
    await getIt.get<StorageService>().deleteToken();
    emit(AuthenticationState.initial());
  }

  void updateUser(User user) {
    emit(state.copyWith(user: user));
  }
}
