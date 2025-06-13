part of 'location_service_cubit.dart';

@freezed
abstract class LocationServiceState with _$LocationServiceState {
  const factory LocationServiceState({
    @Default(LocationPermission.initial) LocationPermission locationPermission,
  }) = _LocationServiceState;
}

enum LocationPermission { granted, denied, initial, disabled }
