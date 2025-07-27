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
}

enum BookingMode { standard, proposal }
