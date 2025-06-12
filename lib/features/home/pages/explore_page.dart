import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:layali_flutter_app/features/home/data/property_data.dart';
import 'package:layali_flutter_app/features/home/widgets/property_card.dart';
import 'package:layali_flutter_app/features/home/widgets/search_field.dart';

@RoutePage()
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: SearchField(),
            ),
            const Gap(16),
            Expanded(
              child: ListView.separated(
                itemBuilder:
                    (context, index) =>
                        PropertyCard(property: properties[index]),
                separatorBuilder: (context, index) => const Gap(24),
                itemCount: properties.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
