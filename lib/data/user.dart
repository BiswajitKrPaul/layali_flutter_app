// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

User userFromJson(String str) =>
    User.fromJson(json.decode(str) as Map<String, dynamic>);

String userToJson(User data) => json.encode(data.toJson());

@freezed
abstract class User with _$User {
  const factory User({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'joined_date') required DateTime joinedDate,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'emergency_contact') String? emergencyContact,
    @JsonKey(name: 'profile_image') String? profileImage,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
