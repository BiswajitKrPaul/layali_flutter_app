part of 'profile_cubit.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(false) bool isDone,
    @Default('') String errorMessage,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String imageUrl,
    @Default('') String phoneNumber,
    @Default('') String address,
    @Default('') String emergencyContact,
    User? user,
  }) = _ProfileState;

  const ProfileState._();

  factory ProfileState.initial() => const ProfileState();

  Map<String, dynamic> apiPatchBody() {
    final mapData = <String, dynamic>{};

    if (firstName.isNotEmpty && user?.firstName != firstName) {
      mapData['first_name'] = firstName;
    }
    if (lastName.isNotEmpty && user?.lastName != lastName) {
      mapData['last_name'] = lastName;
    }
    if (email.isNotEmpty && user?.email != email) {
      mapData['email'] = email;
    }
    if (phoneNumber.isNotEmpty && user?.phoneNumber != phoneNumber) {
      mapData['phone_number'] = phoneNumber;
    }
    if (address.isNotEmpty && user?.address != address) {
      mapData['address'] = address;
    }
    if (emergencyContact.isNotEmpty &&
        user?.emergencyContact != emergencyContact) {
      mapData['emergency_contact'] = emergencyContact;
    }
    return mapData;
  }
}
