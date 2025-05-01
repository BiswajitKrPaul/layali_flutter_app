import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';

@RoutePage()
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.explore),
        centerTitle: true,
      ),
      body: Center(
        child: Text(context.watch<AuthenticationCubit>().state.toString()),
      ),
    );
  }
}
