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

  @POST(path: '/nearby-locations/nearby-locations')
  Future<Response<List<Map<String, dynamic>>>> getPropertyListing(
    @Field('latitude') double latitude,
    @Field('longitude') double password,
    @Field('radius_km') double? radiusKm,
    @Field('city') String? city,
  );
}
