import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../flavor/flavor_config.dart';
import '../interceptors/combining_smart_interceptor.dart';
import '../interceptors/network_auth_interceptor.dart';

@module
abstract class InjectableModule {
  @singleton
  CombiningSmartInterceptor provideCombiningSmartInterceptor(
    NetworkAuthInterceptor authInterceptor,
  ) =>
      CombiningSmartInterceptor()..addInterceptor(authInterceptor);

  @singleton
  Dio dio(CombiningSmartInterceptor interceptor) {

    final dio = Dio(
      BaseOptions(baseUrl: FlavorConfig.instance.values.baseUrl),
    );

    dio.interceptors.addAll([
      interceptor,
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
      ),
      //DioNetworkLogger(),
    ]);
    return dio;
  }
}
