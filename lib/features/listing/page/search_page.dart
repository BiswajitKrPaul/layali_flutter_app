import 'package:auto_route/auto_route.dart';
import 'package:debouncing/debouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/data/lat_lng.dart';
import 'package:layali_flutter_app/features/home/cubits/listing_property_cubit/listing_propety_cubit.dart';
import 'package:layali_flutter_app/features/listing/cubits/place_search_cubit/place_search_cubit.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _debounce = Debounce(delay: const Duration(milliseconds: 300));

  @override
  void dispose() {
    _debounce.flush();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'where_container_card',
              child: Card(
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
                  child: Builder(
                    builder: (context) {
                      return BlocConsumer<PlaceSearchCubit, PlaceSearchState>(
                        listener: (context, state) {
                          if (state.isDone) {
                            context.read<ListingPropetyCubit>().getAllListing(
                              location: LatLng(
                                latitude: state.location!.latitude,
                                longitude: state.location!.longitude,
                              ),
                            );
                            context.router.pop();
                          }
                        },
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Where?',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const Gap(16),
                                TextField(
                                  onChanged: (value) {
                                    _debounce(() {
                                      context.read<PlaceSearchCubit>().search(
                                        value,
                                      );
                                    });
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        context.router.pop();
                                        context
                                            .read<ListingPropetyCubit>()
                                            .getAllListing();
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                    border: const OutlineInputBorder(),
                                    hintText:
                                        context.localizations.startYourSearch,
                                  ),
                                ),
                                const Gap(16),
                                Text(
                                  'Recent searches',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Gap(16),
                                if (state.isLoading)
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                if (state.places == null ||
                                    state.places!.predictions!.isEmpty &&
                                        !state.isLoading)
                                  if (!state.isLoading)
                                    const Text('No recent searches'),
                                if (state.places != null &&
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
                                                      .read<PlaceSearchCubit>()
                                                      .getPlaceId(e.placeId!);
                                                },
                                              ),
                                            )
                                            .toList(),
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
