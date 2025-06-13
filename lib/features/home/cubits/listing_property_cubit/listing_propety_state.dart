part of 'listing_propety_cubit.dart';

@freezed
abstract class ListingPropetyState with _$ListingPropetyState {
  const factory ListingPropetyState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
    @Default([]) List<ListingPropertyModel> properties,
    @Default(LatLng(latitude: 0, longitude: 0)) LatLng location,
  }) = _ListingPropetyState;
}
