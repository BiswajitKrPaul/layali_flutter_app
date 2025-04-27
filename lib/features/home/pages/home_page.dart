import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/common/utils/mixin_utils.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.isAuthenticated == false) {
          context.router.replaceAll(const [LoginPageRoute()]);
        }
      },
      child: AutoTabsScaffold(
        routes: [
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
                icon: Icon(Icons.search_outlined),
                label: context.localizations.explore,
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                label: context.localizations.wishlist,
              ),
              NavigationDestination(
                icon: Icon(Icons.map_outlined),
                label: context.localizations.trips,
              ),
              NavigationDestination(
                icon: Icon(Icons.message_outlined),
                label: context.localizations.inbox,
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outlined),
                label: context.localizations.profile,
              ),
            ],
          );
        },
      ),
    );
  }
}
