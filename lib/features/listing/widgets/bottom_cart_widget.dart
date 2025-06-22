import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/features/home/data/listing_property_model.dart';

class BottomCartWidget extends StatelessWidget {
  const BottomCartWidget({required this.property, super.key});

  final Property property;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '€ ${property.pricePerNight.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        text: '  per night',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.secondaryFixedDim,
                ),
                child: Row(
                  spacing: 4,
                  children: [
                    const Icon(Icons.check, size: 15),
                    Text(
                      'Free Cancellation',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 48,
            width: 140,
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                context.router.push(ListBookingPageRoute(property: property));
              },
              child: const Text('Reserve'),
            ),
          ),
        ],
      ),
    );
  }
}
