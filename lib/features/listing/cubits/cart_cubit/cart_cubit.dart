import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:layali_flutter_app/app_router.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/data/cart_model.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/listing_service.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  final ListingService _restClient =
      getIt.get<RestProtectedService>().client.getService<ListingService>();

  final String dateFormat = 'yyyy-MM-dd';

  void reset() {
    emit(const CartState());
  }

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

  void setStartAndEndDate(DateTime start, DateTime end) {
    final startDate = DateFormat(dateFormat).format(start);
    final endDate = DateFormat(dateFormat).format(end);
    emit(state.copyWith(startDate: startDate, endDate: endDate));
  }

  Future<void> submitCart() async {
    try {
      emit(state.copyWith(isLoading: true));
      final cart = await _restClient.submitCart(
        state.startDate,
        state.endDate,
      );
      if (cart.isSuccessful && cart.body != null) {
        emit(state.copyWith(isDone: true, isLoading: false));
        ScaffoldMessenger.of(
          getIt.get<AppRouter>().navigatorKey.currentContext!,
        ).showSnackBar(
          const SnackBar(
            content: Text('Your cart has been submitted successfully!'),
          ),
        );
        reset();
        await getIt.get<AppRouter>().replaceAll([const HomePageRoute()]);
      } else {
        emit(state.copyWith(isLoading: false));
        ScaffoldMessenger.of(
          getIt.get<AppRouter>().navigatorKey.currentContext!,
        ).showSnackBar(
          const SnackBar(
            content: Text('Submission was not sucessful. Please try again'),
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(isLoading: false));
      ScaffoldMessenger.of(
        getIt.get<AppRouter>().navigatorKey.currentContext!,
      ).showSnackBar(
        const SnackBar(
          content: Text('Submission was not sucessful. Please try again'),
        ),
      );
    }
  }
}
