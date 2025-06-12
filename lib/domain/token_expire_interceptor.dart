import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/injection.dart';

class TokenExpireInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final response = await chain.proceed(chain.request);
    if (response.statusCode == HttpStatus.unauthorized) {
      await getIt.get<AuthenticationCubit>().logout();
      throw Exception('Token expired');
    }
    return response;
  }
}
