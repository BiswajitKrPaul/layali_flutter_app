import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:layali_flutter_app/common/utils/mixin_utils.dart';

@RoutePage()
class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.localizations.wishlist));
  }
}
