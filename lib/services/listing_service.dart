import 'package:chopper/chopper.dart';

part 'listing_service.chopper.dart';

@ChopperApi(baseUrl: '/listing')
abstract class ListingService extends ChopperService {
  static ListingService create([ChopperClient? client]) =>
      _$ListingService(client);

  @POST(path: '/bookings')
  Future<Response<Map<String, dynamic>>> bookProperty(
    @Field('property_id') String propertyId,
    @Field('checkin') String checkInDate,
    @Field('checkout') String checkOutDate,
    @Field('guest_details') Map<String, dynamic> guests,
  );
}
