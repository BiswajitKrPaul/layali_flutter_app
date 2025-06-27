import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:layali_flutter_app/app_router.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/data/error_response.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/listing_service.dart';

part 'book_apartment_cubit.freezed.dart';
part 'book_apartment_state.dart';

class BookApartmentCubit extends Cubit<BookApartmentState> {
  BookApartmentCubit() : super(const BookApartmentState());

  final _restClient =
      getIt.get<RestProtectedService>().client.getService<ListingService>();

  void _softReset() {
    emit(
      state.copyWith(
        isLoading: false,
        isDone: false,
        hasError: false,
        errorMessage: '',
      ),
    );
  }

  void setDefault(int maxGuest) {
    _softReset();
    emit(
      state.copyWith(
        startDate: DateTime.now().add(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 2)),
        maxGuests: maxGuest,
      ),
    );
  }

  void setGuest(int guest) {
    _softReset();
    emit(state.copyWith(guests: guest));
  }

  void setStartAndEndDate(DateTime start, DateTime end) {
    _softReset();
    emit(state.copyWith(startDate: start, endDate: end));
  }

  Future<void> bookApartment(String propertyId) async {
    _softReset();
    try {
      emit(state.copyWith(isLoading: true));
      final response = await _restClient.bookProperty(
        propertyId,
        _getFormattedDate(state.startDate!),
        _getFormattedDate(state.endDate!),
        {'adult': state.guests, 'children': 0, 'infant': 0},
      );
      if (response.isSuccessful) {
        unawaited(
          getIt.get<AppRouter>().replaceAll([
            const HomePageRoute(),
            BookingSuccessPageRoute(
              bookingId:
                  (response.body!['booking'] as Map<String, dynamic>)['id']
                      as String,
            ),
          ]),
        );
      } else {
        emit(
          state.copyWith(
            hasError: true,
            isLoading: false,
            errorMessage:
                ErrorResponse.fromJson(
                  (response.error as Map<String, dynamic>?) ?? {},
                ).detail,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          hasError: true,
          isLoading: false,
          errorMessage:
              "Couldn't book apartment. Please try again in sometime.",
        ),
      );
    }
  }

  String _getFormattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
