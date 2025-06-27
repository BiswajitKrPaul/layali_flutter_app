import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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
          onTap: () async {
            if (!await Geolocator.isLocationServiceEnabled()) {
              await Geolocator.openLocationSettings();
            } else if (await Geolocator.checkPermission() ==
                LocationPermission.denied) {
              await Geolocator.requestPermission();
            } else if (await Geolocator.checkPermission() ==
                    LocationPermission.deniedForever &&
                context.mounted) {
              late AwesomeDialog dialog;
              dialog = AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                title: 'Location Permission Denied by you.',
                desc: 'Please allow location permission in the app settings.',
                btnOkOnPress: () async {
                  await Geolocator.openAppSettings();
                },
                btnOkText: 'Open Settings',
                btnCancelOnPress: () {
                  dialog.dismiss();
                },
              );
              await dialog.show();
            } else {
              if (!context.mounted) return;
              context.read<PlaceSearchCubit>().clear();
              await context.router.push(const SearchPageRoute());
            }
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
