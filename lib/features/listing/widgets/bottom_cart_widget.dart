import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:layali_flutter_app/features/home/data/listing_property_model.dart';

class BottomCartWidget extends StatelessWidget {
  const BottomCartWidget({required this.property, super.key});

  final Property property;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  NumberFormat.currency(
                    locale: 'eu',
                  ).format(property.pricePerNight * 2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    height: 1.5,
                  ),
                ),
                Text(
                  'For 2 night • '
                  '12-13 Aug',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 48,
            width: 140,
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text('Reserve'),
            ),
          ),
        ],
      ),
    );
  }
}
