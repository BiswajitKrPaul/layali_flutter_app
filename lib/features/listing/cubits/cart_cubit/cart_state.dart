part of 'cart_cubit.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartModel> cartItems,
    @Default('') String startDate,
    @Default('') String endDate,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(false) bool isDone,
  }) = _CartState;

  const CartState._();

  bool get hasCartItems => cartItems.isNotEmpty;

  bool hasProperty(String id) =>
      cartItems.any((element) => element.listingId == id);
}
