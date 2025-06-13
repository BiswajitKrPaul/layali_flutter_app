import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_apis/places.dart';
import 'package:layali_flutter_app/data/lat_lng.dart';
import 'package:layali_flutter_app/env.dart';

part 'place_search_cubit.freezed.dart';
part 'place_search_state.dart';

class PlaceSearchCubit extends Cubit<PlaceSearchState> {
  PlaceSearchCubit() : super(const PlaceSearchState());

  final googleMaps = GoogleMapsPlaces(apiKey: Env.googleMapApiKey);

  Future<void> search(String input) async {
    emit(state.copyWith(isLoading: true, placeName: input, isDone: false));
    final predictions = await googleMaps.queryAutocomplete(state.placeName);
    emit(state.copyWith(isLoading: false, places: predictions));
  }

  Future<void> getPlaceId(String placeId) async {
    final data = await googleMaps.getDetailsByPlaceId(placeId);
    emit(
      state.copyWith(
        location: LatLng(
          latitude: data.result!.geometry!.location.lat,
          longitude: data.result!.geometry!.location.lng,
        ),
        isDone: true,
      ),
    );
  }

  void clear() {
    emit(state.copyWith(places: null, isLoading: false, placeName: ''));
  }
}
