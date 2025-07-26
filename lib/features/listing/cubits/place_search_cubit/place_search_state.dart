part of 'place_search_cubit.dart';

@freezed
abstract class PlaceSearchState with _$PlaceSearchState {
  const factory PlaceSearchState({
    @Default(false) bool isLoading,
    @Default(false) bool isDone,
    PlacesAutocompleteResponse? places,
    LatLng? location,
    @Default('') String placeName,
    @Default(false) bool hideListPredicate,
    @Default(false) bool petsAllowed,
    @Default(false) bool smokingAllowed,
    Prediction? selectedPlace,
    @Default([]) List<String> amenities,
    @Default(0) int minGuest,
    @Default(0) int maxGuest,
    @Default(0.0) double minPrice,
    @Default(0.0) double maxPrice,
  }) = _PlaceSearchState;

  factory PlaceSearchState.reset() => const PlaceSearchState();

  const PlaceSearchState._();

  bool hasAmenity(String amenity) => amenities.contains(amenity);
}
