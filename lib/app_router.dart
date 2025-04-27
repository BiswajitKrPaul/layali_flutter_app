import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/injection.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginPageRoute.page),
    AutoRoute(
      page: HomePageRoute.page,
      initial: true,
      children: [
        AutoRoute(page: ExplorePageRoute.page),
        AutoRoute(page: WishlistPageRoute.page),
        AutoRoute(page: TripsPageRoute.page),
        AutoRoute(page: InboxPageRoute.page),
        AutoRoute(page: ProfilePageRoute.page),
      ],
      guards: [AuthGuard()],
    ),
  ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated =
        getIt.get<AuthenticationCubit>().state.isAuthenticated;
    if (isAuthenticated) {
      resolver.next(true);
    } else {
      resolver.redirectUntil(LoginPageRoute());
    }
  }
}
