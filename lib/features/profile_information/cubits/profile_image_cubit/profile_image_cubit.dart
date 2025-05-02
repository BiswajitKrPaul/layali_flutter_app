import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_image_cubit.freezed.dart';
part 'profile_image_state.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit() : super(const ProfileImageState());

  final _picker = ImagePicker();
  final _cropper = ImageCropper();

  void softReset() {
    emit(
      state.copyWith(
        hasError: false,
        isDone: false,
        errorMessage: '',
        imageUrl: '',
      ),
    );
  }

  Future<void> pickImageFromCamera() async {
    softReset();
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        emit(state.copyWith(hasError: true));
      } else {
        final croppedImage = await _cropper.cropImage(sourcePath: image.path);
        if (croppedImage == null) {
          emit(state.copyWith(hasError: true));
        } else {
          emit(state.copyWith(imageUrl: croppedImage.path, isDone: true));
        }
      }
    } catch (e) {
      emit(state.copyWith(hasError: true));
    }
  }

  Future<void> pickImageFromGallery() async {
    softReset();
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        emit(state.copyWith(hasError: true));
      } else {
        final croppedImage = await _cropper.cropImage(sourcePath: image.path);
        if (croppedImage == null) {
          emit(state.copyWith(hasError: true));
        } else {
          emit(state.copyWith(imageUrl: croppedImage.path, isDone: true));
        }
      }
    } catch (e) {
      emit(state.copyWith(hasError: true));
    }
  }
}
