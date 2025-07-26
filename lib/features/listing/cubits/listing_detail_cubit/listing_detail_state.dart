part of 'listing_detail_cubit.dart';

@freezed
abstract class ListingDetailState with _$ListingDetailState {
  const factory ListingDetailState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    PropertyDetailModel? propertyDetailModel,
  }) = _ListingDetailState;

  factory ListingDetailState.initial() => const ListingDetailState();
}
