import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:layali_flutter_app/features/home/data/property_data.dart';

class PropertyCard extends StatefulWidget {
  const PropertyCard({required this.property, super.key});
  final Property property;

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
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

  var _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Stack(
            children: [
              // Image Carousel
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
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
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: _buildDotIndicator(imgList.length, _currentImageIndex),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.property.price,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.property.address,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildAmenity(
                        Icons.king_bed,
                        '${widget.property.bedrooms} Bedrooms',
                      ),
                      const SizedBox(width: 16),
                      _buildAmenity(
                        Icons.bathtub,
                        '${widget.property.bathrooms} Bathrooms',
                      ),
                      const SizedBox(width: 16),
                      _buildAmenity(
                        Icons.square_foot,
                        '${widget.property.sqft} sqft',
                      ),
                      const SizedBox(width: 16),
                      _buildAmenity(
                        Icons.king_bed,
                        '${widget.property.bedrooms} Bedrooms',
                      ),
                      const SizedBox(width: 16),
                      _buildAmenity(
                        Icons.king_bed,
                        '${widget.property.bedrooms} Bedrooms',
                      ),
                      const SizedBox(width: 16),
                      _buildAmenity(
                        Icons.king_bed,
                        '${widget.property.bedrooms} Bedrooms',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenity(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon, size: 20), const SizedBox(width: 4), Text(text)],
    );
  }

  Widget _buildDotIndicator(int itemCount, int currentIndex) {
    const maxVisibleDots = 5;

    // Calculate the range of dots to show
    int startDot;
    int endDot;

    if (itemCount <= maxVisibleDots) {
      // Show all dots if total is 5 or less
      startDot = 0;
      endDot = itemCount - 1;
    } else {
      // Show a sliding window of 5 dots
      const halfWindow = maxVisibleDots ~/ 2;

      if (currentIndex <= halfWindow) {
        // Near the beginning - show first 5 dots
        startDot = 0;
        endDot = maxVisibleDots - 1;
      } else if (currentIndex >= itemCount - 1 - halfWindow) {
        // Near the end - show last 5 dots
        startDot = itemCount - maxVisibleDots;
        endDot = itemCount - 1;
      } else {
        // In the middle - show dots centered around current index
        startDot = currentIndex - halfWindow;
        endDot = currentIndex + halfWindow;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        // Only show dots in the calculated range
        if (index >= startDot && index <= endDot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
