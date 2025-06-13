import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'location_service_cubit.freezed.dart';
part 'location_service_state.dart';

@singleton
class LocationServiceCubit extends Cubit<LocationServiceState> {
  LocationServiceCubit() : super(const LocationServiceState());

  Future<void> getLocationPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      final status = await Permission.location.status;

      if (status == PermissionStatus.granted) {
        emit(state.copyWith(locationPermission: LocationPermission.granted));
      } else if (status == PermissionStatus.denied) {
        emit(state.copyWith(locationPermission: LocationPermission.denied));
      } else if (status == PermissionStatus.permanentlyDenied) {
        emit(state.copyWith(locationPermission: LocationPermission.denied));
      }
    } else {
      emit(state.copyWith(locationPermission: LocationPermission.disabled));
    }
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      emit(state.copyWith(locationPermission: LocationPermission.granted));
    } else if (status == PermissionStatus.denied) {
      emit(state.copyWith(locationPermission: LocationPermission.denied));
    } else if (status == PermissionStatus.permanentlyDenied) {
      emit(state.copyWith(locationPermission: LocationPermission.denied));
    }
  }
}
