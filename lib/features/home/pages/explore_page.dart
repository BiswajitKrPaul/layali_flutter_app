import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart' hide LocationPermission;
import 'package:layali_flutter_app/common/cubits/location_service_cubit/location_service_cubit.dart';
import 'package:layali_flutter_app/features/home/cubits/listing_property_cubit/listing_propety_cubit.dart';
import 'package:layali_flutter_app/features/home/widgets/property_card.dart';
import 'package:layali_flutter_app/features/home/widgets/search_field.dart';
import 'package:layali_flutter_app/injection.dart';

@RoutePage()
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _listScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _listScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_listScrollController.position.pixels ==
            _listScrollController.position.maxScrollExtent &&
        !context.read<ListingPropetyCubit>().state.hasReachLastPage) {
      context.read<ListingPropetyCubit>().getNextPage();
    }
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LocationServiceCubit, LocationServiceState>(
          builder: (context, state) {
            if (state.locationPermission == LocationPermission.initial ||
                state.locationPermission == LocationPermission.denied) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Location permission not provided.'),
                    FilledButton(
                      onPressed: () {
                        getIt
                            .get<LocationServiceCubit>()
                            .requestLocationPermission();
                      },
                      child: const Text('Give Location Permission'),
                    ),
                  ],
                ),
              );
            } else if (state.locationPermission ==
                LocationPermission.disabled) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Location service not enabled.'),
                    FilledButton(
                      onPressed: () async {
                        await Geolocator.openLocationSettings();
                      },
                      child: const Text('Enable Location Service'),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: SearchField(),
                ),
                const Gap(16),
                Expanded(
                  child: BlocBuilder<ListingPropetyCubit, ListingPropetyState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.properties?.results.isEmpty ?? true) {
                        return const Center(child: Text('No Properties found'));
                      }
                      return ListView.separated(
                        controller: _listScrollController,
                        itemBuilder: (context, index) {
                          if (index == state.totalItems) {
                            return const Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return PropertyCard(
                            property: state.properties!.results[index],
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(24),
                        itemCount:
                            state.hasReachLastPage
                                ? state.totalItems
                                : state.totalItems + 1,
                      );
                    },
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
