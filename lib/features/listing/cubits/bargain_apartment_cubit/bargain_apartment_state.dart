part of 'bargain_apartment_cubit.dart';

@freezed
sealed class BargainApartmentState with _$BargainApartmentState {
  const factory BargainApartmentState({
    @Default(false) bool isLoading,
    @Default(false) bool isDone,
    @Default(0.0) double pricePerNight,
  }) = _BargainApartmentState;
}
