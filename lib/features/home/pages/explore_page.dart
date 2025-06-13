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
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

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
                      } else if (state.properties.isEmpty) {
                        return const Center(child: Text('No Properties found'));
                      }
                      return ListView.separated(
                        itemBuilder:
                            (context, index) =>
                                PropertyCard(property: state.properties[index]),
                        separatorBuilder: (context, index) => const Gap(24),
                        itemCount: state.properties.length,
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
