part of 'book_apartment_cubit.dart';

@freezed
abstract class BookApartmentState with _$BookApartmentState {
  const factory BookApartmentState({
    DateTime? startDate,
    DateTime? endDate,
    @Default(1) int guests,
    @Default(1) int maxGuests,
    @Default(false) bool isLoading,
    @Default(false) bool isDone,
    @Default(false) bool hasError,
    String? errorMessage,
  }) = _BookApartmentState;

  const BookApartmentState._();

  int noOfDays() =>
      endDate?.difference(startDate ?? DateTime.now()).inDays ?? 1;
}
