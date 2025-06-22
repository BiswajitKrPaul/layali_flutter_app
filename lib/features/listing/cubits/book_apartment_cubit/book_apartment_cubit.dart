import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_apartment_cubit.freezed.dart';
part 'book_apartment_state.dart';

class BookApartmentCubit extends Cubit<BookApartmentState> {
  BookApartmentCubit() : super(const BookApartmentState());

  void setDefault(int maxGuest) {
    emit(
      state.copyWith(
        startDate: DateTime.now().add(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 2)),
        maxGuests: maxGuest,
      ),
    );
  }

  void setGuest(int guest) {
    emit(state.copyWith(guests: guest));
  }

  void setStartAndEndDate(DateTime start, DateTime end) {
    emit(state.copyWith(startDate: start, endDate: end));
  }
}
