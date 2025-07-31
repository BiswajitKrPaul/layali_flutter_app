import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:layali_flutter_app/app_router.dart';
import 'package:layali_flutter_app/common/utils/constants.dart';
import 'package:layali_flutter_app/features/listing/cubits/cart_cubit/cart_cubit.dart';
import 'package:layali_flutter_app/features/listing/cubits/cart_item_cubit/cart_item_cubit.dart';
import 'package:layali_flutter_app/features/listing/page/listing_detail.dart';
import 'package:layali_flutter_app/injection.dart';

@RoutePage()
class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state.cartItems.isEmpty) {
            context.read<CartCubit>().reset();
            getIt.get<AppRouter>().pop();
          }
        },
        builder: (context, cartState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Gap(4),
                    itemCount:
                        context.watch<CartCubit>().state.cartItems.length,
                    itemBuilder: (context, index) {
                      return BlocProvider(
                        create: (context) => CartItemCubit(),
                        child: Builder(
                          builder: (context) {
                            return BlocBuilder<CartItemCubit, CartItemState>(
                              builder: (context, state) {
                                final item =
                                    getIt
                                        .get<CartCubit>()
                                        .state
                                        .cartItems[index];
                                return Card(
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: imgList.first,
                                      ),
                                    ),
                                    titleTextStyle: GoogleFonts.ibmPlexMono(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer,
                                    ),
                                    title: Text(item.listing.title),
                                    subtitleTextStyle: GoogleFonts.ibmPlexMono(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer,
                                    ),
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
                                                            .read<
                                                              CartItemCubit
                                                            >()
                                                            .removePropertyFromCart(
                                                              item.listingId,
                                                            );
                                                      },
                                              icon: const Icon(Icons.delete),
                                            ),
                                    iconColor:
                                        Theme.of(context).colorScheme.error,
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
                const Spacer(),
                ListTile(
                  onTap: () async {
                    final selectedDateRange = await showDateRangePicker(
                      context: context,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      initialDateRange:
                          cartState.startDate.isNotEmpty &&
                                  cartState.endDate.isNotEmpty
                              ? DateTimeRange(
                                start: DateTime.parse(cartState.startDate),
                                end: DateTime.parse(cartState.endDate),
                              )
                              : null,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 180),
                      ),
                    );
                    if (selectedDateRange != null) {
                      if (!context.mounted) return;
                      context.read<CartCubit>().setStartAndEndDate(
                        selectedDateRange.start,
                        selectedDateRange.end,
                      );
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  leadingAndTrailingTextStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                  ),
                  titleTextStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  subtitleTextStyle: Theme.of(context).textTheme.bodyLarge,
                  title: const Text('Dates'),
                  subtitle:
                      cartState.startDate.isEmpty
                          ? const Text('Select dates for your trip')
                          : Text(getDate(context)),
                  trailing: const Text('Edit'),
                ),
                const Gap(16),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed:
                        cartState.isLoading ||
                                cartState.startDate.isEmpty ||
                                cartState.endDate.isEmpty ||
                                cartState.cartItems.length <= 1
                            ? null
                            : () {
                              context.read<CartCubit>().submitCart();
                            },
                    child:
                        cartState.isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                              'Submit (Minimun 2 properties required)',
                              style: GoogleFonts.ibmPlexMono(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String getDate(BuildContext context) {
    final start = context.watch<CartCubit>().state.startDate;
    final end = context.watch<CartCubit>().state.endDate;
    return '${DateFormat.MMMd().format(DateTime.parse(start))} - ${DateFormat.MMMd().format(DateTime.parse(end))}';
  }
}
