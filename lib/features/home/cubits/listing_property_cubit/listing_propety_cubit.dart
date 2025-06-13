import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:layali_flutter_app/data/error_response.dart';
import 'package:layali_flutter_app/data/lat_lng.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/features/home/data/listing_property_model.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/property_service.dart';

part 'listing_propety_cubit.freezed.dart';
part 'listing_propety_state.dart';

class ListingPropetyCubit extends Cubit<ListingPropetyState> {
  ListingPropetyCubit() : super(const ListingPropetyState());

  final _restClient =
      getIt.get<RestProtectedService>().client.getService<PropertyService>();

  void softReset() {
    emit(state.copyWith(hasError: false, errorMessage: ''));
  }

  Future<void> getAllListing({LatLng? location}) async {
    softReset();
    emit(state.copyWith(isLoading: true));
    LatLng data;
    if (location == null) {
      final pos = await Geolocator.getCurrentPosition();
      data = LatLng(latitude: pos.latitude, longitude: pos.longitude);
    } else {
      data = location;
    }
    final response = await _restClient.getPropertyListing(
      data.latitude,
      data.longitude,
      10,
      null,
    );
    if (response.isSuccessful && response.body != null) {
      final listing =
          response.body!.map(ListingPropertyModel.fromJson).toList();
      emit(
        state.copyWith(
          isLoading: false,
          properties: listing,
          location: LatLng(latitude: data.latitude, longitude: data.longitude),
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage:
              ErrorResponse.fromJson(
                (response.error as Map<String, dynamic>?) ?? {},
              ).detail,
        ),
      );
    }
  }
}
