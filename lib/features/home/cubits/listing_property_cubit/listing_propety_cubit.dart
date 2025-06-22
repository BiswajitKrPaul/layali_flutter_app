import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
    emit(
      state.copyWith(
        hasError: false,
        errorMessage: '',
        page: 1,
        hasReachLastPage: false,
      ),
    );
  }

  Future<void> getAllListing({LatLng? location}) async {
    softReset();
    emit(state.copyWith(isLoading: true));
    final response = await _restClient.getPropertyListing(
      location?.latitude,
      location?.longitude,
      null,
      null,
      1,
      null,
    );
    if (response.isSuccessful && response.body != null) {
      final listing = ListingPropertyModel.fromJson(response.body!);
      emit(
        state.copyWith(
          isLoading: false,
          properties: listing,
          location: location,
          page: listing.page,
          totalItems: listing.results.length,
          hasReachLastPage: listing.total == listing.results.length,
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

  Future<void> getNextPage() async {
    if (state.hasReachLastPage) return;
    final currentPage = state.page + 1;
    final response = await _restClient.getPropertyListing(
      state.location?.latitude,
      state.location?.longitude,
      null,
      null,
      currentPage,
      null,
    );
    if (response.isSuccessful) {
      final listing = ListingPropertyModel.fromJson(response.body!);
      final data = [...state.properties!.results, ...listing.results];
      emit(
        state.copyWith(
          properties: state.properties!.copyWith(
            limit: listing.limit,
            page: listing.page,
            total: listing.total,
            results: data,
          ),
          page: currentPage,
          totalItems: data.length,
          hasReachLastPage: listing.total == data.length,
        ),
      );
    }
  }
}
