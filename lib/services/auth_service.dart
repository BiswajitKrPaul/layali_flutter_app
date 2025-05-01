// YOUR_FILE.dart

import 'package:chopper/chopper.dart';

// This is necessary for the generator to work.
part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: '/auth')
abstract class AuthService extends ChopperService {
  // A helper method that helps instantiating the service.
  //You can omit this method and use the generated class directly instead.
  static AuthService create([ChopperClient? client]) => _$AuthService(client);

  @POST(path: '/register')
  Future<Response<Map<String, dynamic>>> register(
    @Field('email') String email,
    @Field('password') String password,
    @Field('first_name') String firstName,
    @Field('last_name') String lastName,
    @Field('confirm_password') String confirmPassword,
  );

  @POST(path: '/login')
  Future<Response<Map<String, dynamic>>> login(
    @Field('email') String email,
    @Field('password') String password,
  );
}
