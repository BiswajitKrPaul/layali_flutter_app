import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';

@RoutePage()
class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.localizations.inbox));
  }
}
