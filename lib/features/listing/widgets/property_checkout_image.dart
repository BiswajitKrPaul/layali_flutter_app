import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:layali_flutter_app/features/home/data/listing_property_model.dart';
import 'package:layali_flutter_app/features/listing/cubits/book_apartment_cubit/book_apartment_cubit.dart';
import 'package:layali_flutter_app/features/listing/page/listing_detail.dart';

class PropertyCheckOutImage extends StatelessWidget {
  const PropertyCheckOutImage({required this.property, super.key});

  final Property property;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.maxFinite,
        child: ColoredBox(
          color: Colors.white,
          child: Column(
            spacing: 16,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: imgList.first,
                      height: 120,
                      width: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          property.propertyType,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '€ ${property.pricePerNight.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(
                            text: 'Free cancellation before',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ' ${DateFormat('d MMM').format(context.watch<BookApartmentCubit>().state.startDate!.subtract(const Duration(days: 1)))}.',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' Get a full refund if you change your mind.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.calendar_today_outlined, size: 28),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
