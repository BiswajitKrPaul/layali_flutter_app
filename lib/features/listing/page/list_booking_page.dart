import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:layali_flutter_app/common/utils/constants.dart';
import 'package:layali_flutter_app/features/home/data/listing_property_model.dart';
import 'package:layali_flutter_app/features/listing/cubits/book_apartment_cubit/book_apartment_cubit.dart';
import 'package:layali_flutter_app/features/listing/widgets/cart_counter.dart';
import 'package:layali_flutter_app/features/listing/widgets/property_checkout_image.dart';

@RoutePage()
class ListBookingPage extends StatefulWidget implements AutoRouteWrapper {
  const ListBookingPage({required this.property, super.key});

  final Property property;

  @override
  State<ListBookingPage> createState() => _ListBookingPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => BookApartmentCubit()..setDefault(property.maxGuests),
      child: this,
    );
  }
}

class _ListBookingPageState extends State<ListBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm and pay'), elevation: 2),
      body: BlocConsumer<BookApartmentCubit, BookApartmentState>(
        listener: (context, state) {
          if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ??
                      "Couldn't book apartment. Please try again in sometime.",
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              PropertyCheckOutImage(property: widget.property),
              Gap(8, color: Colors.grey.shade300),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ColoredBox(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Yout trip',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const Gap(16),
                        ListTile(
                          onTap: () async {
                            final selectedDateRange = await showDateRangePicker(
                              context: context,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              initialDateRange:
                                  state.startDate != null &&
                                          state.endDate != null
                                      ? DateTimeRange(
                                        start: state.startDate!,
                                        end: state.endDate!,
                                      )
                                      : null,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 180),
                              ),
                            );
                            if (selectedDateRange != null) {
                              if (!context.mounted) return;
                              context
                                  .read<BookApartmentCubit>()
                                  .setStartAndEndDate(
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
                          titleTextStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                          subtitleTextStyle:
                              Theme.of(context).textTheme.bodyLarge,
                          title: const Text('Dates'),
                          subtitle: Text(getDate(context)),
                          trailing: const Text('Edit'),
                        ),
                        ListTile(
                          onTap: () {
                            showModalBottomSheet<Widget>(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              context: context,
                              builder: (_) {
                                return _guestSelectionWidget(context, state);
                              },
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          leadingAndTrailingTextStyle: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                          titleTextStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                          subtitleTextStyle:
                              Theme.of(context).textTheme.bodyLarge,
                          title: const Text('Guests'),
                          subtitle: Text(
                            '${state.guests} ${Intl.plural(state.guests as num, one: 'guest', other: 'guests')}',
                          ),
                          trailing: const Text('Edit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(8, color: Colors.grey.shade300),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ColoredBox(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Yout total',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const Gap(16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16,
                          children: [
                            Expanded(
                              child: Column(
                                spacing: 8,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${Constants.euroSymbol}${widget.property.pricePerNight.toStringAsFixed(2)} x ${state.noOfDays()} night',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Taxes',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${Constants.euroSymbol}${((widget.property.pricePerNight) * (state.noOfDays()) * state.guests).toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                const Text('${Constants.euroSymbol}${100.00}'),
                              ],
                            ),
                          ],
                        ),
                        const Gap(12),
                        const Divider(),
                        const Gap(12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                                children: [
                                  const TextSpan(text: 'Total'),
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                    text: '(EUR)',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${Constants.euroSymbol}${(((widget.property.pricePerNight) * (state.noOfDays()) * state.guests) + 100).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 48,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed:
                        state.isLoading
                            ? null
                            : () {
                              context.read<BookApartmentCubit>().bookApartment(
                                widget.property.id,
                              );
                            },
                    child:
                        state.isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                              'Proceed to pay',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _guestSelectionWidget(BuildContext context, BookApartmentState state) {
    final bloc = context.read<BookApartmentCubit>();
    return BlocProvider.value(
      value: bloc,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        'Guests',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => context.router.pop(),
                  ),
                ],
              ),
              const Divider(),
              const Gap(8),
              Text(
                'This place has maximum of ${state.maxGuests} ${Intl.plural(state.maxGuests, one: 'guest', other: 'guests')}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Gap(16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Adults'),
                subtitle: Text(
                  'Age 13+',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: CartCounter(
                  initialValue: state.guests,
                  maxValue: state.maxGuests,
                  onChanged:
                      (guest) =>
                          context.read<BookApartmentCubit>().setGuest(guest),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Children'),
                subtitle: Text(
                  'Ages 2-12',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: CartCounter(maxValue: state.maxGuests, minValue: 0),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Infants'),
                subtitle: Text(
                  'Under 2',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: const CartCounter(maxValue: 5, minValue: 0),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Pets'),
                subtitle: Text(
                  'Maximum 1 allowed',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: const CartCounter(maxValue: 1, minValue: 0),
              ),
              const Gap(8),
              const Divider(),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  const Spacer(),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      context.router.pop();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDate(BuildContext context) {
    final start = context.watch<BookApartmentCubit>().state.startDate;
    final end = context.watch<BookApartmentCubit>().state.endDate;
    return '${DateFormat.MMMMd().format(start!)} - ${DateFormat.MMMMd().format(end!)}';
  }
}
