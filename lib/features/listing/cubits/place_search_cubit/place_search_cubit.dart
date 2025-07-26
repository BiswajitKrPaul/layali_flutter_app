import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_apis/places.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/data/lat_lng.dart';
import 'package:layali_flutter_app/env.dart';

part 'place_search_cubit.freezed.dart';
part 'place_search_state.dart';

@singleton
class PlaceSearchCubit extends Cubit<PlaceSearchState> {
  PlaceSearchCubit() : super(const PlaceSearchState());

  final googleMaps = GoogleMapsPlaces(apiKey: Env.googleMapApiKey);

  void softReset() {
    emit(state.copyWith(isDone: false, isLoading: false));
  }

  void setPetsAllowed({bool value = false}) {
    emit(state.copyWith(petsAllowed: value));
  }

  void setSmokingAllowed({bool value = false}) {
    emit(state.copyWith(smokingAllowed: value));
  }

  void setOrRemoveAmenities(String amenity) {
    if (state.amenities.contains(amenity)) {
      final index = state.amenities.indexOf(amenity);
      final tempList = [...state.amenities]..removeAt(index);
      emit(state.copyWith(amenities: [...tempList]));
    } else {
      emit(state.copyWith(amenities: [...state.amenities, amenity]));
    }
  }

  void changeGuests(int min, int max) {
    emit(state.copyWith(minGuest: min, maxGuest: max));
  }

  void changePrice(double min, double max) {
    emit(state.copyWith(minPrice: min, maxPrice: max));
  }

  Future<void> search(String input) async {
    emit(
      state.copyWith(
        isLoading: true,
        placeName: input,
        isDone: false,
        hideListPredicate: false,
      ),
    );
    final predictions = await googleMaps.queryAutocomplete(state.placeName);
    emit(state.copyWith(isLoading: false, places: predictions));
  }

  Future<void> getPlaceId(Prediction p) async {
    emit(state.copyWith(selectedPlace: p));
    final data = await googleMaps.getDetailsByPlaceId(p.placeId!);
    emit(
      state.copyWith(
        location: LatLng(
          latitude: data.result!.geometry!.location.lat,
          longitude: data.result!.geometry!.location.lng,
        ),
        isDone: false,
        hideListPredicate: true,
      ),
    );
  }

  void searchWithFilters() {
    emit(state.copyWith(isDone: true));
  }

  void clearFilters() {
    emit(
      state.copyWith(
        location: null,
        petsAllowed: false,
        smokingAllowed: false,
        amenities: [],
        placeName: '',
        places: null,
        hideListPredicate: false,
        isDone: true,
        selectedPlace: null,
        maxGuest: 6,
        minGuest: 0,
        minPrice: 0,
        maxPrice: 6,
      ),
    );
  }

  void hidePredicate() {
    emit(
      state.copyWith(
        places: null,
        isLoading: false,
        placeName: '',
        hideListPredicate: false,
      ),
    );
  }

  void clearText() {
    emit(state.copyWith(selectedPlace: null, hideListPredicate: false));
  }

  void clear() {
    emit(
      state.copyWith(
        places: null,
        isLoading: false,
        placeName: '',
        hideListPredicate: false,
        isDone: false,
        location: null,
        amenities: [],
        petsAllowed: false,
        selectedPlace: null,
        smokingAllowed: false,
        maxGuest: 6,
        minGuest: 0,
        minPrice: 0,
        maxPrice: 6,
      ),
    );
  }
}
