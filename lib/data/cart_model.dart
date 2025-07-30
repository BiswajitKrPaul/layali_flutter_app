// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
sealed class CartModel with _$CartModel {
  const factory CartModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'listing_id') required String listingId,
    @JsonKey(name: 'listing') required Listing listing,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}

@freezed
sealed class Listing with _$Listing {
  const factory Listing({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'price_per_night') required double pricePerNight,
    @JsonKey(name: 'location') required Location location,
    @JsonKey(name: 'images') required List<String> images,
  }) = _Listing;

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);
}

@freezed
sealed class Location with _$Location {
  const factory Location({
    @JsonKey(name: 'city') required String city,
    @JsonKey(name: 'country') required Country country,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
sealed class Country with _$Country {
  const factory Country({@JsonKey(name: 'name') required String name}) =
      _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
