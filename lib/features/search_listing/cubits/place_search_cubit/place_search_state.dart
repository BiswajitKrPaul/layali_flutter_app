part of 'place_search_cubit.dart';

@freezed
abstract class PlaceSearchState with _$PlaceSearchState {
  const factory PlaceSearchState({
    @Default(false) bool isLoading,
    @Default(false) bool isDone,
    PlacesAutocompleteResponse? places,
    LatLng? location,
    @Default('') String placeName,
  }) = _PlaceSearchState;
}
