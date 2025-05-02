part of 'profile_image_cubit.dart';

@freezed
abstract class ProfileImageState with _$ProfileImageState {
  const factory ProfileImageState({
    @Default('') String imageUrl,
    @Default(false) bool isDone,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _ProfileImageState;
}
