import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:layali_flutter_app/app_router.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/domain/rest_client.dart';
import 'package:layali_flutter_app/injection.dart';
import 'package:layali_flutter_app/services/listing_service.dart';

part 'bargain_apartment_cubit.freezed.dart';
part 'bargain_apartment_state.dart';

class BargainApartmentCubit extends Cubit<BargainApartmentState> {
  BargainApartmentCubit() : super(const BargainApartmentState());

  final _restClient =
      getIt.get<RestProtectedService>().client.getService<ListingService>();

  void setPrice(double price) {
    emit(state.copyWith(pricePerNight: price, isDone: false, isLoading: false));
  }

  Future<void> proposedPropertyPrice(
    int guests,
    String propertyId,
    BuildContext ctx,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, isDone: false));
      final response = await _restClient.bookProperty(
        propertyId: propertyId,
        guests: {'adult': guests, 'children': 0, 'infant': 0},
        checkInDate: _getFormattedDate(startDate),
        checkOutDate: _getFormattedDate(endDate),
        proposedPrice: state.pricePerNight,
        mode: BookingMode.proposal.name,
      );
      if (response.isSuccessful) {
        if (ctx.mounted) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text('Your new proposal has been sent!')),
          );
        }
        unawaited(getIt.get<AppRouter>().replaceAll([const HomePageRoute()]));
      } else {
        if (ctx.mounted) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text(
                (jsonDecode(response.bodyString)
                        as Map<String, dynamic>)['detail']
                    as String,
              ),
            ),
          );
        }
        emit(state.copyWith(isLoading: false, isDone: false));
      }
    } catch (e) {
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Something went wrong!!!')),
        );
      }
      emit(state.copyWith(isLoading: false, isDone: false));
    }
  }

  String _getFormattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
