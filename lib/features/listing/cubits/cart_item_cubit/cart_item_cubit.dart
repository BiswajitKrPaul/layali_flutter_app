import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:layali_flutter_app/app_router.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/features/listing/cubits/cart_cubit/cart_cubit.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/listing_service.dart';

part 'cart_item_cubit.freezed.dart';
part 'cart_item_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  CartItemCubit() : super(const CartItemState());

  final _restClient =
      getIt.get<RestProtectedService>().client.getService<ListingService>();

  Future<void> addPropertyToCart(String propertyId) async {
    try {
      emit(state.copyWith(isLoading: true));
      final cart = await _restClient.addPropertyToCart(propertyId);
      if (cart.isSuccessful && cart.body != null) {
        await getIt.get<CartCubit>().getUserCart();
        emit(state.copyWith(isLoading: false));
      } else {
        ScaffoldMessenger.of(
          getIt.get<AppRouter>().navigatorKey.currentContext!,
        ).showSnackBar(
          const SnackBar(
            content: Text("Couldn't add the item. Please try again"),
          ),
        );
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> removePropertyFromCart(String propertyId) async {
    try {
      emit(state.copyWith(isLoading: true));
      final cart = await _restClient.removePropertyFromCart(propertyId);
      if (cart.isSuccessful && cart.body != null) {
        await getIt.get<CartCubit>().getUserCart();
        emit(state.copyWith(isLoading: false));
      } else {
        ScaffoldMessenger.of(
          getIt.get<AppRouter>().navigatorKey.currentContext!,
        ).showSnackBar(
          const SnackBar(
            content: Text('Cart item not removed. Please try again'),
          ),
        );
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
