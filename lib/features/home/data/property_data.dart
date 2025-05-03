final List<Property> properties = [
  Property(
    price: r'$842,00',
    address: '8502 Rd. Inglewood, California 98380',
    bedrooms: 4,
    bathrooms: 3,
    sqft: 2135,
  ),
  Property(
    price: r'$1.212,00',
    address: '6391 Elgin St. Celina, California 98380',
    bedrooms: 4,
    bathrooms: 2,
    sqft: 2897,
  ),
  Property(
    price: r'$921,00',
    address: '2715 Ash Dr. San Jose, California 98380',
    bedrooms: 4,
    bathrooms: 2,
    sqft: 2755,
  ),
  Property(
    price: r'$811,00',
    address: '1901 Thornridge, California 98380',
    bedrooms: 3,
    bathrooms: 2,
    sqft: 2241,
  ),
  Property(
    price: r'$901,00',
    address: '2464 Royal Ln. Mesa, California 98380',
    bedrooms: 5,
    bathrooms: 3,
    sqft: 2642,
  ),
  Property(
    price: r'$901,00',
    address: '2464 Royal Ln. Mesa, California 98380',
    bedrooms: 5,
    bathrooms: 3,
    sqft: 2642,
  ),
  Property(
    price: r'$901,00',
    address: '2464 Royal Ln. Mesa, California 98380',
    bedrooms: 5,
    bathrooms: 3,
    sqft: 2642,
  ),
  Property(
    price: r'$901,00',
    address: '2464 Royal Ln. Mesa, California 98380',
    bedrooms: 5,
    bathrooms: 3,
    sqft: 2642,
  ),
  Property(
    price: r'$901,00',
    address: '2464 Royal Ln. Mesa, California 98380',
    bedrooms: 5,
    bathrooms: 3,
    sqft: 2642,
  ),
];

class Property {
  Property({
    required this.price,
    required this.address,
    required this.bedrooms,
    required this.bathrooms,
    required this.sqft,
  });
  final String price;
  final String address;
  final int bedrooms;
  final int bathrooms;
  final int sqft;
}
