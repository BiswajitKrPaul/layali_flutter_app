import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/home/cubits/listing_property_cubit/listing_propety_cubit.dart';
import 'package:layali_flutter_app/features/listing/cubits/place_search_cubit/place_search_cubit.dart';

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
            context.read<PlaceSearchCubit>().clear();
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
                  context.watch<PlaceSearchCubit>().state.placeName.isEmpty
                      ? context.localizations.startYourSearch
                      : context.watch<PlaceSearchCubit>().state.placeName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (context
                    .watch<PlaceSearchCubit>()
                    .state
                    .placeName
                    .isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      context.read<PlaceSearchCubit>().clear();
                      context.read<ListingPropetyCubit>().getAllListing();
                    },
                    child: const Icon(Icons.close),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
