// To parse this JSON data, do
//
//     final myTripsModel = myTripsModelFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_trips_model.freezed.dart';
part 'my_trips_model.g.dart';

MyTripsModel myTripsModelFromJson(String str) =>
    MyTripsModel.fromJson(json.decode(str) as Map<String, dynamic>);

String myTripsModelToJson(MyTripsModel data) => json.encode(data.toJson());

@freezed
abstract class MyTripsModel with _$MyTripsModel {
  const factory MyTripsModel({
    @JsonKey(name: 'bookings') required List<Booking> bookings,
  }) = _MyTripsModel;

  factory MyTripsModel.fromJson(Map<String, dynamic> json) =>
      _$MyTripsModelFromJson(json);
}

@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    @JsonKey(name: 'booking_id') required String bookingId,
    @JsonKey(name: 'checkin') required DateTime checkin,
    @JsonKey(name: 'checkout') required DateTime checkout,
    @JsonKey(name: 'guest_details') required GuestDetails guestDetails,
    @JsonKey(name: 'property') required Property property,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}

@freezed
abstract class GuestDetails with _$GuestDetails {
  const factory GuestDetails({
    @JsonKey(name: 'adult') required int adult,
    @JsonKey(name: 'children') required int children,
    @JsonKey(name: 'infant') required int infant,
  }) = _GuestDetails;

  factory GuestDetails.fromJson(Map<String, dynamic> json) =>
      _$GuestDetailsFromJson(json);
}

@freezed
abstract class Property with _$Property {
  const factory Property({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'listing_type') required String listingType,
    @JsonKey(name: 'property_type') required String propertyType,
    @JsonKey(name: 'max_guests') required int maxGuests,
    @JsonKey(name: 'bedrooms') required int bedrooms,
    @JsonKey(name: 'beds') required int beds,
    @JsonKey(name: 'bathrooms') required int bathrooms,
    @JsonKey(name: 'amenities') required List<String> amenities,
    @JsonKey(name: 'price_per_night') required int pricePerNight,
  }) = _Property;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
}
