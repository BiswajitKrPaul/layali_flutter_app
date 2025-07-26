// To parse this JSON data, do
//
//     final amenitiesListModel = amenitiesListModelFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'amenities_list_model.freezed.dart';
part 'amenities_list_model.g.dart';

AmenitiesListModel amenitiesListModelFromJson(String str) =>
    AmenitiesListModel.fromJson(json.decode(str) as Map<String, dynamic>);

String amenitiesListModelToJson(AmenitiesListModel data) =>
    json.encode(data.toJson());

@freezed
sealed class AmenitiesListModel with _$AmenitiesListModel {
  const factory AmenitiesListModel({
    @JsonKey(name: 'amenities') required List<String> amenities,
  }) = _AmenitiesListModel;

  factory AmenitiesListModel.fromJson(Map<String, dynamic> json) =>
      _$AmenitiesListModelFromJson(json);
}
