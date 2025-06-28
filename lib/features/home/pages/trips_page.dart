import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/home/cubits/my_trips_cubit/my_trips_cubit.dart';
import 'package:layali_flutter_app/features/home/widgets/trip_card.dart';
import 'package:layali_flutter_app/features/listing/page/listing_detail.dart';

@RoutePage()
class TripsPage extends StatelessWidget implements AutoRouteWrapper {
  const TripsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => MyTripsCubit()..getMyTrips(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localizations.trips,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 36),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<MyTripsCubit, MyTripsState>(
          builder: (tripContext, tripState) {
            if (tripState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (tripState.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Text(
                      "Couldn't load trips. Please try to refresh.",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          tripContext.read<MyTripsCubit>().getMyTrips();
                        },
                        child: const Text('Refresh'),
                      ),
                    ),
                  ],
                ),
              );
            } else if (tripState.myTripsModel?.bookings.isEmpty ?? true) {
              return Center(
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Trips found',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          tripContext.read<MyTripsCubit>().getMyTrips();
                        },
                        child: const Text('Refresh'),
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () => tripContext.read<MyTripsCubit>().getMyTrips(),
              child: ListView.builder(
                itemBuilder:
                    (context, index) => TripCard(
                      bookingStatus: 'confirmed',
                      checkInDate:
                          tripState.myTripsModel!.bookings[index].checkin,
                      checkOutDate:
                          tripState.myTripsModel!.bookings[index].checkout,
                      imageUrl: imgList.first,
                      destination:
                          tripState
                              .myTripsModel!
                              .bookings[index]
                              .property
                              .title,
                      onTap: () => {},
                    ),
                itemCount: tripState.myTripsModel!.bookings.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
