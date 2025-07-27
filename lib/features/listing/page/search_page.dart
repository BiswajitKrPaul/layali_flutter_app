import 'package:auto_route/auto_route.dart';
import 'package:debouncing/debouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:layali_flutter_app/common/cubits/amenities_list_cubit/amenities_list_cubit.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/home/cubits/listing_property_cubit/listing_propety_cubit.dart';
import 'package:layali_flutter_app/features/listing/cubits/place_search_cubit/place_search_cubit.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _debounce = Debounce(delay: const Duration(milliseconds: 300));
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final selectedPredicate =
        context.read<PlaceSearchCubit>().state.selectedPlace;
    if (selectedPredicate != null) {
      _controller.text = selectedPredicate.description ?? '';
    }
  }

  @override
  void dispose() {
    _debounce.flush();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PlaceSearchCubit, PlaceSearchState>(
          listener: (context, state) {
            if (state.hideListPredicate) {
              _controller.text = state.selectedPlace?.description ?? '';
              context.read<PlaceSearchCubit>().hidePredicate();
            }
            if (state.isDone) {
              context.read<ListingPropetyCubit>().getAllListing(
                latitude: state.location?.latitude,
                longitude: state.location?.longitude,
                isPetAllowed:
                    state.petsAllowed == true ? state.petsAllowed : null,
                isSmokingAllowed:
                    state.smokingAllowed == true ? state.smokingAllowed : null,
                amenities: state.amenities.isEmpty ? null : state.amenities,
                maxGuest:
                    state.maxGuest == 0 || state.maxGuest == 6
                        ? null
                        : state.maxGuest,
                minGuest:
                    state.minGuest == 0 || state.minGuest == 6
                        ? null
                        : state.minGuest,
                maxPrice:
                    state.maxPrice == 0.0 || state.maxPrice == 6.0
                        ? null
                        : state.maxPrice * 200,
                minPrice:
                    state.minPrice == 0 || state.minPrice == 6
                        ? null
                        : state.minPrice * 200,
                radius: state.radiusInKm,
              );
              context.router.pop();
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Hero(
                          tag: 'where_container_card',
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Where?',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.headlineLarge,
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                      controller: _controller,
                                      onChanged: (value) {
                                        _debounce(() {
                                          context
                                              .read<PlaceSearchCubit>()
                                              .search(value);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _controller.clear();
                                            context
                                                .read<PlaceSearchCubit>()
                                                .clearText();
                                          },
                                          child: const Icon(Icons.close),
                                        ),
                                        border: const OutlineInputBorder(),
                                        hintText:
                                            context
                                                .localizations
                                                .startYourSearch,
                                      ),
                                    ),
                                    // Text(
                                    //   'Recent searches',
                                    //   style:
                                    //       Theme.of(
                                    //         context,
                                    //       ).textTheme.bodySmall,
                                    // ),
                                    const Gap(16),
                                    if (state.isLoading)
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    if (!state.hideListPredicate &&
                                        state.places != null &&
                                        state.places!.predictions!.isNotEmpty &&
                                        !state.isLoading)
                                      Column(
                                        children:
                                            state.places!.predictions!
                                                .map(
                                                  (e) => ListTile(
                                                    title: Text(e.description!),
                                                    onTap: () {
                                                      context
                                                          .read<
                                                            PlaceSearchCubit
                                                          >()
                                                          .getPlaceId(e);
                                                    },
                                                  ),
                                                )
                                                .toList(),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.all(16),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'More Filters',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Pets Allowed'),
                                  value: state.petsAllowed,
                                  onChanged: (value) {
                                    context
                                        .read<PlaceSearchCubit>()
                                        .setPetsAllowed(value: value ?? false);
                                  },
                                ),
                                CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Smoking Allowed'),
                                  value: state.smokingAllowed,
                                  onChanged: (value) {
                                    context
                                        .read<PlaceSearchCubit>()
                                        .setSmokingAllowed(
                                          value: value ?? false,
                                        );
                                  },
                                ),
                                const Gap(8),
                                const Text(
                                  'Radius (in Km)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SfSlider(
                                  value: state.radiusInKm,
                                  max: 50,
                                  min: 10,
                                  showTicks: true,
                                  showLabels: true,
                                  interval: 10,
                                  stepSize: 10,
                                  onChanged: (value) {
                                    context
                                        .read<PlaceSearchCubit>()
                                        .setRadiusInKm(
                                          (value as double).toInt(),
                                        );
                                  },
                                ),
                                const Gap(16),
                                const Text(
                                  'Guests',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SfRangeSlider(
                                  max: 6,
                                  min: 0,
                                  values: SfRangeValues(
                                    state.minGuest,
                                    state.maxGuest,
                                  ),
                                  showTicks: true,
                                  showLabels: true,
                                  labelFormatterCallback: (
                                    actualValue,
                                    formattedText,
                                  ) {
                                    if (actualValue == 0) {
                                      return 'Any';
                                    }
                                    if (actualValue == 6) {
                                      return 'Any';
                                    } else {
                                      return formattedText;
                                    }
                                  },
                                  interval: 1,
                                  dragMode: SliderDragMode.both,
                                  onChanged: (value) {
                                    context
                                        .read<PlaceSearchCubit>()
                                        .changeGuests(
                                          (value.start as double).toInt(),
                                          (value.end as double).toInt(),
                                        );
                                  },
                                ),
                                const Gap(16),
                                const Text(
                                  'Price (in €)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SfRangeSlider(
                                  max: 6,
                                  min: 0,
                                  values: SfRangeValues(
                                    state.minPrice,
                                    state.maxPrice,
                                  ),
                                  showTicks: true,
                                  showLabels: true,
                                  labelFormatterCallback: (
                                    actualValue,
                                    formattedText,
                                  ) {
                                    if (actualValue == 0) {
                                      return 'Any';
                                    }
                                    if (actualValue == 6) {
                                      return 'Any';
                                    } else {
                                      return ((actualValue as double) * 200)
                                          .toInt()
                                          .toString();
                                    }
                                  },
                                  interval: 1,
                                  stepSize: 1,
                                  dragMode: SliderDragMode.both,
                                  onChanged: (value) {
                                    context
                                        .read<PlaceSearchCubit>()
                                        .changePrice(
                                          value.start as double,
                                          value.end as double,
                                        );
                                  },
                                ),
                                const Gap(16),
                                const Text(
                                  'Has Amenities',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  children: [
                                    for (final String data
                                        in context
                                            .read<AmenitiesListCubit>()
                                            .state
                                            .amenities)
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ChoiceChip(
                                          selected: state.hasAmenity(data),
                                          onSelected: (value) {
                                            context
                                                .read<PlaceSearchCubit>()
                                                .setOrRemoveAmenities(data);
                                          },
                                          label: Text(data),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<PlaceSearchCubit>().clearFilters();
                          },
                          child: const Text('Clear Filters'),
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            context
                                .read<PlaceSearchCubit>()
                                .searchWithFilters();
                          },
                          child: const Text('Search'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
