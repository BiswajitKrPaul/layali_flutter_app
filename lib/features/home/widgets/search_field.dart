import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'where_container_card',
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: InkWell(
          onTap: () {
            context.router.push(const SearchPageRoute());
          },
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                const Icon(Icons.search),
                Text(
                  context.localizations.startYourSearch,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
