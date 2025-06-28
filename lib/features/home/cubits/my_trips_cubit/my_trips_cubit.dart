import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/features/home/data/my_trips_model.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/listing_service.dart';

part 'my_trips_cubit.freezed.dart';
part 'my_trips_state.dart';

class MyTripsCubit extends Cubit<MyTripsState> {
  MyTripsCubit() : super(const MyTripsState());

  final _restClient =
      getIt.get<RestProtectedService>().client.getService<ListingService>();

  Future<void> getMyTrips() async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await _restClient.getAllTrips();
      if (response.isSuccessful) {
        final myTripsModel = MyTripsModel.fromJson(response.body!);
        emit(state.copyWith(myTripsModel: myTripsModel, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } on Exception catch (_) {
      emit(state.copyWith(hasError: true, isLoading: false));
    }
  }
}
