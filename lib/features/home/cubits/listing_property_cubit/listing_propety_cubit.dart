import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:layali_flutter_app/data/error_response.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/features/home/data/listing_property_model.dart';
import 'package:layali_flutter_app/features/listing/cubits/place_search_cubit/place_search_cubit.dart';
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

  Future<void> getAllListing({
    double? latitude,
    double? longitude,
    int? maxGuest,
    int? minGuest,
    double? minPrice,
    double? maxPrice,
    bool? isSmokingAllowed,
    bool? isPetAllowed,
    List<String>? amenities,
    int radius = 10,
  }) async {
    softReset();
    emit(state.copyWith(isLoading: true));
    final response = await _restClient.getPropertyListing(
      latitude: latitude,
      longitude: longitude,
      isPetAllowed: isPetAllowed,
      isSmokingAllowed: isSmokingAllowed,
      maxGuest: maxGuest,
      minGuest: minGuest,
      minPrice: minPrice,
      maxPrice: maxPrice,
      amenities: amenities,
      radiusKm: radius.toDouble(),
    );
    if (response.isSuccessful && response.body != null) {
      final listing = ListingPropertyModel.fromJson(response.body!);
      emit(
        state.copyWith(
          isLoading: false,
          properties: listing,
          latitude: latitude,
          longitude: longitude,
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
    final currentState = getIt.get<PlaceSearchCubit>().state;
    final response = await _restClient.getPropertyListing(
      latitude: state.latitude,
      longitude: state.longitude,
      page: currentPage,
      isPetAllowed:
          currentState.petsAllowed == true ? currentState.petsAllowed : null,
      isSmokingAllowed:
          currentState.smokingAllowed == true
              ? currentState.smokingAllowed
              : null,
      amenities: currentState.amenities.isEmpty ? null : currentState.amenities,
      maxGuest:
          currentState.maxGuest == 0 || currentState.maxGuest == 6
              ? null
              : currentState.maxGuest,
      minGuest:
          currentState.minGuest == 0 || currentState.minGuest == 6
              ? null
              : currentState.minGuest,
      maxPrice:
          currentState.maxPrice == 0 || currentState.maxPrice == 6
              ? null
              : currentState.maxPrice * 200,
      minPrice:
          currentState.minPrice == 0 || currentState.minPrice == 6
              ? null
              : currentState.minPrice * 200,
      radiusKm: currentState.radiusInKm.toDouble(),
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
