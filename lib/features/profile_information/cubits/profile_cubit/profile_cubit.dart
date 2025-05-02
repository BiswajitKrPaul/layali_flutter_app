import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/data/error_response.dart';
import 'package:layali_flutter_app/data/user.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/user_service.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  final _restClient =
      getIt.get<RestProtectedService>().client.getService<UserService>();

  void setUserData(User user) {
    emit(
      state.copyWith(
        user: user,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phoneNumber: user.phoneNumber ?? '',
        address: user.address ?? '',
        emergencyContact: user.emergencyContact ?? '',
      ),
    );
  }

  void setFirstName(String? value) {
    softReset();
    emit(state.copyWith(firstName: value ?? ''));
  }

  void setLastName(String? value) {
    softReset();
    emit(state.copyWith(lastName: value ?? ''));
  }

  void setPhoneNumber(String? value) {
    softReset();
    emit(state.copyWith(phoneNumber: value ?? ''));
  }

  void setAddress(String? value) {
    softReset();
    emit(state.copyWith(address: value ?? ''));
  }

  void setEmergencyContact(String? value) {
    softReset();
    emit(state.copyWith(emergencyContact: value ?? ''));
  }

  void softReset() {
    emit(state.copyWith(isDone: false, hasError: false, errorMessage: ''));
  }

  Future<void> updateProfile() async {
    try {
      softReset();
      emit(state.copyWith(isLoading: true));
      final response = await _restClient.updateProfile(state.apiPatchBody());
      if (response.isSuccessful) {
        final user = User.fromJson(response.body!);
        emit(state.copyWith(user: user));
        getIt.get<AuthenticationCubit>().updateUser(user);
        emit(state.copyWith(isDone: true, isLoading: false));
      } else {
        emit(
          state.copyWith(
            hasError: true,
            isLoading: false,
            errorMessage:
                ErrorResponse.fromJson(
                  (response.error as Map<String, dynamic>?) ?? {},
                ).detail,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(hasError: true, isLoading: false));
    }
  }

  Future<void> uploadProfileImage(String imageUrl) async {
    softReset();
    emit(state.copyWith(isLoading: true));
    final imgFile = await MultipartFile.fromPath('file', imageUrl);
    final response = await _restClient.uploadProfileImage(imgFile);
    if (response.isSuccessful) {
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
  }
}
