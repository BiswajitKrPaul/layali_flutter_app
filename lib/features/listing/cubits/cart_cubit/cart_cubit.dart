import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/data/cart_model.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/listing_service.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@singleton
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  final _restClient =
      getIt.get<RestProtectedService>().client.getService<ListingService>();

  Future<void> getUserCart() async {
    try {
      final cart = await _restClient.getPropertyDetails();
      if (cart.isSuccessful && cart.body != null) {
        emit(
          state.copyWith(
            cartItems: cart.body!.map(CartModel.fromJson).toList(),
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(hasError: true));
    }
  }
}
