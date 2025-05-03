import 'package:chopper/chopper.dart';
import 'package:http/http.dart' show MultipartFile;

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: '/user')
abstract class UserService extends ChopperService {
  // A helper method that helps instantiating the service.
  // You can omit this method and use the generated class directly instead.
  static UserService create([ChopperClient? client]) => _$UserService(client);

  @GET(path: '/profile-me')
  Future<Response<Map<String, dynamic>>> getProfile();

  @PATCH(path: '/update-user', optionalBody: true)
  Future<Response<Map<String, dynamic>>> updateProfile(
    @Body() Map<String, dynamic> body,
  );

  @POST(path: '/upload-profile-image')
  @Multipart()
  Future<Response<Map<String, dynamic>>> uploadProfileImage(
    @PartFile('file') MultipartFile filePath,
  );
}
