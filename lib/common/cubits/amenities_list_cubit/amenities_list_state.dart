part of 'amenities_list_cubit.dart';

@freezed
abstract class AmenitiesListState with _$AmenitiesListState {
  const factory AmenitiesListState({@Default([]) List<String> amenities}) =
      _AmenitiesListState;

  factory AmenitiesListState.initial() => const AmenitiesListState();
}
