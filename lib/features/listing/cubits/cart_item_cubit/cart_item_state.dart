part of 'cart_item_cubit.dart';

@freezed
abstract class CartItemState with _$CartItemState {
  const factory CartItemState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
  }) = _CartItemState;
}
