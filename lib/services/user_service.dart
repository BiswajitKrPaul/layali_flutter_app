import 'package:chopper/chopper.dart';

part 'user_service.chopper.dart';

@ChopperApi()
abstract class UserService extends ChopperService {
  // A helper method that helps instantiating the service. You can omit this method and use the generated class directly instead.
  static UserService create([ChopperClient? client]) => _$UserService(client);

  @GET(path: "/profile-me")
  Future<Response<Map<String, dynamic>>> getProfile();
}
