import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/home/data/property_data.dart';
import 'package:layali_flutter_app/features/home/widgets/property_card.dart';

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
      body: ListView.separated(
        itemBuilder:
            (context, index) => PropertyCard(property: properties[index]),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: properties.length,
      ),
    );
  }
}
