import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/features/listing/data/property_detail_model.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/property_service.dart';

part 'listing_detail_cubit.freezed.dart';
part 'listing_detail_state.dart';

class ListingDetailCubit extends Cubit<ListingDetailState> {
  ListingDetailCubit() : super(ListingDetailState.initial());

  final _restClient =
      getIt.get<RestProtectedService>().client.getService<PropertyService>();

  Future<void> getPropertyDetail(String id) async {
    try {
      emit(state.copyWith(isLoading: true, hasError: false));
      final response = await _restClient.getPropertyDetails(propertyId: id);
      if (response.isSuccessful && response.body != null) {
        emit(
          state.copyWith(
            propertyDetailModel: PropertyDetailModel.fromJson(response.body!),
            isLoading: false,
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false, hasError: true));
      }
    } on Exception catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
