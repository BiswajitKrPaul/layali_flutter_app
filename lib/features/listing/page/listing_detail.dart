import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/home/data/listing_property_model.dart';
import 'package:layali_flutter_app/features/listing/widgets/bottom_cart_widget.dart';

final imgList = [
  'https://rook.gumlet.io/uploads/center/cover_photo/635cf57206f5720001fae616/jpeg_optimizer_3___2024_07_09T193937.115.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/65697d47080bc60001dac0c5/DSC08705_01_copy_1423x949.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/675a91930d7f46000111412d/7__1_.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/668d44f20b66370001ebed0f/12__87_.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center/cover_photo/635cf57206f5720001fae616/jpeg_optimizer_3___2024_07_09T193937.115.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/65697d47080bc60001dac0c5/DSC08705_01_copy_1423x949.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/675a91930d7f46000111412d/7__1_.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/668d44f20b66370001ebed0f/12__87_.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center/cover_photo/635cf57206f5720001fae616/jpeg_optimizer_3___2024_07_09T193937.115.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/65697d47080bc60001dac0c5/DSC08705_01_copy_1423x949.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/675a91930d7f46000111412d/7__1_.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/668d44f20b66370001ebed0f/12__87_.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center/cover_photo/635cf57206f5720001fae616/jpeg_optimizer_3___2024_07_09T193937.115.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/65697d47080bc60001dac0c5/DSC08705_01_copy_1423x949.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/675a91930d7f46000111412d/7__1_.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
  'https://rook.gumlet.io/uploads/center_caption_photo/photo/668d44f20b66370001ebed0f/12__87_.jpg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=100%&ar=1.5',
];

@RoutePage()
class ListingDetail extends StatelessWidget {
  const ListingDetail({required this.propertyModel, super.key});

  final Property propertyModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageBehindListScreen(property: propertyModel),
          Align(
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -4), // Negative Y offset for top shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 80,
                    width: double.maxFinite,
                    child: BottomCartWidget(property: propertyModel),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageBehindListScreen extends StatefulWidget {
  const ImageBehindListScreen({required this.property, super.key});
  final Property property;

  @override
  State<ImageBehindListScreen> createState() => _ImageBehindListScreenState();
}

class _ImageBehindListScreenState extends State<ImageBehindListScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          leading: IconButton.filledTonal(
            onPressed: () {
              context.router.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.ios_share),
            ),
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline),
            ),
            const Gap(8),
          ],
          expandedHeight: 350,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    height: Platform.isIOS ? 420 : 400,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  items:
                      imgList.map((url) {
                        return CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder:
                              (context, url) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                        );
                      }).toList(),
                ),
                Align(
                  alignment: const Alignment(0.9, 0.85),
                  child: SizedBox(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.secondaryFixedDim,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          ' ${_currentImageIndex + 1} / ${imgList.length}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size(20, 20),
            child: SizedBox(
              height: 20,
              width: double.maxFinite,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Divider(thickness: 5, indent: 180, endIndent: 180),
              ),
            ),
          ),
        ),

        // List container with top rounded corners
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.property.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const Gap(12),
                Text(
                  '${widget.property.listingType} in ${widget.property.propertyType} located at ${widget.property.location.city}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text:
                            '${widget.property.maxGuests} ${Intl.plural(widget.property.maxGuests, one: "guest", other: "guests")}',
                      ),
                      const TextSpan(text: ' • '),
                      TextSpan(
                        text:
                            '${widget.property.details.bedrooms} ${Intl.plural(widget.property.details.bedrooms, one: "bedroom", other: "bedrooms")}',
                      ),
                      const TextSpan(text: ' • '),
                      TextSpan(
                        text:
                            '${widget.property.details.beds} ${Intl.plural(widget.property.details.beds, one: "bed", other: "beds")}',
                      ),
                      const TextSpan(text: ' • '),
                      TextSpan(
                        text:
                            '${widget.property.details.bathrooms} ${Intl.plural(widget.property.details.bathrooms, one: "bathroom", other: "bathrooms")}',
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(imgList[2]),
                  ),
                  title: Text(
                    'Hosted by ${widget.property.host.firstName} ${widget.property.host.lastName}',
                  ),
                  subtitle: const Text('2 years hosting'),
                  titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                  subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.key_outlined),
                  title: const Text('Exceptional check-in experience'),
                  subtitle: const Text(
                    'Recent guests gave the check-in process a 5-star rating.',
                  ),
                  titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                  subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.door_back_door_outlined),
                  title: const Text('Self check-in'),
                  subtitle: const Text(
                    'You can check in with the building staff.',
                  ),
                  titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                  subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                ),
                const Divider(),
                Text(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  widget.property.description,
                ),
                Visibility(
                  visible: AppUtils.hasTextOverflow(
                    widget.property.description,
                    null,
                    null,
                    maxLines: 5,
                    maxWidth: MediaQuery.of(context).size.shortestSide - 40,
                  ),
                  child: const Gap(12),
                ),
                Visibility(
                  visible: AppUtils.hasTextOverflow(
                    widget.property.description,
                    null,
                    null,
                    maxLines: 5,
                    maxWidth: MediaQuery.of(context).size.shortestSide - 40,
                  ),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: FilledButton.tonal(
                      onPressed: () {
                        showDialog<AlertDialog>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Description'),
                              content: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 300,
                                ),
                                child: SingleChildScrollView(
                                  child: Text(widget.property.description),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Show More'),
                    ),
                  ),
                ),
                Visibility(
                  visible: AppUtils.hasTextOverflow(
                    widget.property.description,
                    null,
                    null,
                    maxLines: 5,
                    maxWidth: MediaQuery.of(context).size.shortestSide - 40,
                  ),
                  child: const Gap(12),
                ),
                const Divider(),
                const Gap(12),
                Text(
                  "Where you'll sleep",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(12),
                SizedBox(
                  child: Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(imgList[1]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'Bedroom',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '1 queen bed',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(imgList[2]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'Living Room',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '1 sofa bed',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                const Divider(),
                const Gap(12),
                Text(
                  'What this place offers',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(16),
                Row(
                  children: [
                    const Icon(Icons.wifi),
                    const Gap(8),
                    Text('Wifi', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const Gap(16),
                Row(
                  children: [
                    const Icon(Icons.tv),
                    const Gap(8),
                    Text(
                      'Flat-screen TV',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Gap(16),
                Row(
                  children: [
                    const Icon(Icons.air),
                    const Gap(8),
                    Text(
                      'Air conditioning',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Gap(16),
                Row(
                  children: [
                    const Icon(Icons.pool),
                    const Gap(8),
                    Text(
                      'Pool',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                Row(
                  children: [
                    const Icon(Icons.door_sliding_outlined),
                    const Gap(8),
                    Text('Lift', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const Gap(16),
                Row(
                  children: [
                    const Icon(Icons.garage_outlined),
                    const Gap(8),
                    Text(
                      'Car Parking',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Gap(140),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
