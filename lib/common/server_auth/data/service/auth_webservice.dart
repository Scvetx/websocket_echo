import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/auth_response.dart';

part 'auth_webservice.g.dart';

@lazySingleton
@RestApi()
abstract class AuthWebService {
  @factoryMethod
  factory AuthWebService(Dio dio) = _AuthWebService;

  @POST("/auth/login")
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);
}