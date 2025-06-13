import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/common/cubits/location_service_cubit/location_service_cubit.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/home/cubits/listing_property_cubit/listing_propety_cubit.dart';
import 'package:layali_flutter_app/injection.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getIt.get<LocationServiceCubit>().getLocationPermission().then((value) {
      if (getIt.get<LocationServiceCubit>().state.locationPermission ==
          LocationPermission.granted) {
        if (mounted) {
          context.read<ListingPropetyCubit>().getAllListing();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.isAuthenticated == false) {
          context.router.replaceAll(const [LoginPageRoute()]);
        }
      },
      child: AutoTabsScaffold(
        routes: const [
          ExplorePageRoute(),
          WishlistPageRoute(),
          TripsPageRoute(),
          InboxPageRoute(),
          ProfilePageRoute(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) {
          return NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.search_outlined),
                label: context.localizations.explore,
              ),
              NavigationDestination(
                icon: const Icon(Icons.favorite_outline),
                label: context.localizations.wishlist,
              ),
              NavigationDestination(
                icon: const Icon(Icons.map_outlined),
                label: context.localizations.trips,
              ),
              NavigationDestination(
                icon: const Icon(Icons.message_outlined),
                label: context.localizations.inbox,
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outlined),
                label: context.localizations.profile,
              ),
            ],
          );
        },
      ),
    );
  }
}
