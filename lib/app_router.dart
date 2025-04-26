import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/app_router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginPageRoute.page, initial: true),
  ];
}

final navigatorKey = GlobalKey<NavigatorState>();
