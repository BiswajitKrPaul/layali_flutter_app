import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/data/amenities_list_model.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/amenities_service.dart';

part 'amenities_list_cubit.freezed.dart';
part 'amenities_list_state.dart';

@lazySingleton
class AmenitiesListCubit extends Cubit<AmenitiesListState> {
  AmenitiesListCubit() : super(AmenitiesListState.initial());

  final _rest =
      getIt.get<RestProtectedService>().client.getService<AmenitiesService>();

  Future<void> getAmenitiesList() async {
    if (state.amenities.isNotEmpty) return;
    final response = await _rest.getAllAmenities();
    if (response.isSuccessful && response.body != null) {
      final allAmenities = AmenitiesListModel.fromJson(response.body!);
      emit(state.copyWith(amenities: allAmenities.amenities));
    }
  }
}
