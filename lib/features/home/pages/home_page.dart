import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:layali_flutter_app/app_router.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/common/cubits/amenities_list_cubit/amenities_list_cubit.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/home/cubits/listing_property_cubit/listing_propety_cubit.dart';
import 'package:layali_flutter_app/features/listing/cubits/cart_cubit/cart_cubit.dart';
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
    getIt.get<CartCubit>().getUserCart();
    getIt.get<AmenitiesListCubit>().getAmenitiesList();
    context.read<ListingPropetyCubit>().getAllListing();
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
        floatingActionButton:
            context.watch<CartCubit>().state.cartItems.isNotEmpty
                ? FloatingActionButton.extended(
                  extendedPadding: const EdgeInsets.symmetric(horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  label: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('View Cart'),
                      Text(
                        '${context.watch<CartCubit>().state.cartItems.length} ${Intl.plural(context.watch<CartCubit>().state.cartItems.length, one: 'item', other: 'items')}',
                        style: GoogleFonts.ibmPlexMono(fontSize: 12),
                      ),
                    ],
                  ),
                  onPressed: () {
                    getIt.get<AppRouter>().navigate(const CartListPageRoute());
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                )
                : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
