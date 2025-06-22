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
abstract class ListingPropertyModel with _$ListingPropertyModel {
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
abstract class Property with _$Property {
  const factory Property({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'host') required Host host,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'listing_type') required String listingType,
    @JsonKey(name: 'property_type') required String propertyType,
    @JsonKey(name: 'max_guests') required int maxGuests,
    @JsonKey(name: 'details') required Details details,
    @JsonKey(name: 'price_per_night') required int pricePerNight,
    @JsonKey(name: 'availability') required List<Availability> availability,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'location') required Location location,
    @JsonKey(name: 'images') required List<Image> images,
    @JsonKey(name: 'amenities') required List<String> amenities,
  }) = _Property;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
}

@freezed
abstract class Availability with _$Availability {
  const factory Availability({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
  }) = _Availability;

  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);
}

@freezed
abstract class Details with _$Details {
  const factory Details({
    @JsonKey(name: 'bedrooms') required int bedrooms,
    @JsonKey(name: 'beds') required int beds,
    @JsonKey(name: 'bathrooms') required int bathrooms,
  }) = _Details;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
}

@freezed
abstract class Host with _$Host {
  const factory Host({
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
  }) = _Host;

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);
}

@freezed
abstract class Image with _$Image {
  const factory Image({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'image_url') required String imageUrl,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

@freezed
abstract class Location with _$Location {
  const factory Location({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'city') required String city,
    @JsonKey(name: 'country') required Country country,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
abstract class Country with _$Country {
  const factory Country({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
