import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/injection.dart';

class ApplyHeaderInterceptor implements Interceptor {
  ApplyHeaderInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final token = getIt.get<AuthenticationCubit>().state.token;
    final request = applyHeader(
      chain.request,
      'Authorization',
      'Bearer $token',
    );
    return chain.proceed(request);
  }
}
