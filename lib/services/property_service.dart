// YOUR_FILE.dart

import 'package:chopper/chopper.dart';

// This is necessary for the generator to work.
part 'property_service.chopper.dart';

@ChopperApi()
abstract class PropertyService extends ChopperService {
  // A helper method that helps instantiating the service.
  //You can omit this method and use the generated class directly instead.
  static PropertyService create([ChopperClient? client]) =>
      _$PropertyService(client);

  @GET(path: '/nearby-locations/nearby-locations')
  Future<Response<Map<String, dynamic>>> getPropertyListing(
    @Query('latitude') double? latitude,
    @Query('longitude') double? longitude,
    @Query('radius_km') double? radiusKm,
    @Query('city') String? city,
    @Query('page') int page,
    @Query('limit') int? limit,
  );
}
