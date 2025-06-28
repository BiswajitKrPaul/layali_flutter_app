part of 'my_trips_cubit.dart';

@freezed
abstract class MyTripsState with _$MyTripsState {
  const factory MyTripsState({
    MyTripsModel? myTripsModel,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _MyTripsState;
}
