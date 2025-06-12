import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'where_container_card',
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.all(16),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Where?',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const Gap(16),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.close),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: context.localizations.startYourSearch,
                          ),
                        ),
                        const Gap(16),
                        Text(
                          'Recent searches',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Gap(16),
                        const ListTile(
                          leading: Icon(Icons.location_city),
                          title: Text('Bangalore'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
