// To parse this JSON data, do
//
//     final registrationErrorResponse = registrationErrorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';
part 'error_response.g.dart';

ErrorResponse registrationErrorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

@freezed
abstract class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    @JsonKey(name: 'detail') required String detail,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}

@freezed
abstract class Detail with _$Detail {
  const factory Detail({
    @JsonKey(name: 'loc') required List<dynamic> loc,
    @JsonKey(name: 'msg') required String msg,
    @JsonKey(name: 'type') required String type,
  }) = _Detail;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
}
