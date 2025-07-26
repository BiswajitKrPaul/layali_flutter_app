// To parse this JSON data, do
//
//     final listingPropertyModel = listingPropertyModelFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing_property_model.freezed.dart';
part 'listing_property_model.g.dart';

ListingPropertyModel listingPropertyModelFromJson(String str) =>
    ListingPropertyModel.fromJson(json.decode(str) as Map<String, dynamic>);

String listingPropertyModelToJson(ListingPropertyModel data) =>
    json.encode(data.toJson());

@freezed
sealed class ListingPropertyModel with _$ListingPropertyModel {
  const factory ListingPropertyModel({
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'limit') required int limit,
    @JsonKey(name: 'total') required int total,
    @JsonKey(name: 'results') required List<Property> results,
  }) = _ListingPropertyModel;

  factory ListingPropertyModel.fromJson(Map<String, dynamic> json) =>
      _$ListingPropertyModelFromJson(json);
}

@freezed
sealed class Property with _$Property {
  const factory Property({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'price_per_night') required int pricePerNight,
    @JsonKey(name: 'images') required List<Image> images,
  }) = _Property;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
}

@freezed
sealed class Image with _$Image {
  const factory Image({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'image_url') required String imageUrl,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
