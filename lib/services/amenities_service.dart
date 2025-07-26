import 'package:chopper/chopper.dart';

part 'amenities_service.chopper.dart';

@ChopperApi(baseUrl: '/amenities')
abstract class AmenitiesService extends ChopperService {
  static AmenitiesService create([ChopperClient? client]) =>
      _$AmenitiesService(client);

  @GET()
  Future<Response<Map<String, dynamic>>> getAllAmenities();
}
