import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/common/utils/constants.dart';
import 'package:layali_flutter_app/features/listing/cubits/cart_cubit/cart_cubit.dart';
import 'package:layali_flutter_app/features/listing/cubits/cart_item_cubit/cart_item_cubit.dart';
import 'package:layali_flutter_app/injection.dart';

@RoutePage()
class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: context.watch<CartCubit>().state.cartItems.length,
          itemBuilder: (context, index) {
            return BlocProvider(
              create: (context) => CartItemCubit(),
              child: Builder(
                builder: (context) {
                  return BlocBuilder<CartItemCubit, CartItemState>(
                    builder: (context, state) {
                      final item =
                          getIt.get<CartCubit>().state.cartItems[index];
                      return Card(
                        child: ListTile(
                          title: Text(item.listing.title),
                          subtitle: Text(
                            '${Constants.euroSymbol} ${item.listing.pricePerNight}',
                          ),
                          trailing:
                              state.isLoading
                                  ? const CircularProgressIndicator()
                                  : IconButton(
                                    onPressed:
                                        state.isLoading
                                            ? null
                                            : () {
                                              context
                                                  .read<CartItemCubit>()
                                                  .removePropertyFromCart(
                                                    item.listingId,
                                                  );
                                            },
                                    icon: const Icon(Icons.delete),
                                  ),
                          iconColor: Theme.of(context).colorScheme.error,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
