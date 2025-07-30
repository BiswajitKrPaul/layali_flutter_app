import 'package:chopper/chopper.dart';

part 'listing_service.chopper.dart';

@ChopperApi(baseUrl: '/listing')
abstract class ListingService extends ChopperService {
  static ListingService create([ChopperClient? client]) =>
      _$ListingService(client);

  @POST(path: '/booking-or-proposal')
  Future<Response<Map<String, dynamic>>> bookProperty({
    @Field('property_id') required String propertyId,
    @Field('mode') required String mode,
    @Field('checkin') String? checkInDate,
    @Field('checkout') String? checkOutDate,
    @Field('guest_details') Map<String, dynamic>? guests,
    @Field('proposed_price') double? proposedPrice,
  });

  @GET(path: '/my-bookings')
  Future<Response<Map<String, dynamic>>> getAllTrips();

  @GET(path: '/multi-request/cart')
  Future<Response<List<Map<String, dynamic>>>> getPropertyDetails();

  @POST(path: '/multi-request/add')
  Future<Response<Map<String, dynamic>>> addPropertyToCart(
    @Field('property_id') String propertyId,
  );

  @DELETE(path: '/multi-request/remove/{listing_id}')
  Future<Response<Map<String, dynamic>>> removePropertyFromCart(
    @Path('listing_id') String listingId,
  );
}

enum BookingMode { standard, proposal }
