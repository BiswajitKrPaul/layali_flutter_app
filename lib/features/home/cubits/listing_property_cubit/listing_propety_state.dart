part of 'listing_propety_cubit.dart';

@freezed
abstract class ListingPropetyState with _$ListingPropetyState {
  const factory ListingPropetyState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
    ListingPropertyModel? properties,
    @Default(0) int totalItems,
    LatLng? location,
    @Default(1) int page,
    @Default(false) bool hasReachLastPage,
  }) = _ListingPropetyState;
}
