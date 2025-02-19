import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';

// Project imports:
import '../../common/constants/app_const.dart';
import '../../common/global.dart';
import '../../common/server_auth/data/repository/auth_repository.dart';
import '../../injectable.dart';
import 'combining_smart_interceptor.dart';

@singleton
class NetworkAuthInterceptor extends SimpleInterceptor {
  final _excludedPaths = [
    'login',
  ];

  @override
  Future<Object?> onRequest(RequestOptions options) async {
    if (_excludedPaths.contains(options.path)) {
      return super.onRequest(options);
    }
    final token = await getIt<AuthRepository>().getToken();
    if (token == null) return null;

    if (options.method != "GET" &&
        !options.headers.containsKey('Content-Type')) {
      options.headers['Content-Type'] = "application/json; charset=utf-8";
    }

    final authorizationHeader =
        '${AppConst.HEADER_PROTECTED_AUTHENTICATION_PREFIX} $token';
    options.headers[AppConst.HEADER_AUTHORIZATION] = authorizationHeader;
    options.headers[AppConst.HEADER_ACCEPT_LANGUAGE] = Global.getLocale();
    return options;
  }

  @override
  Future<Object?> onError(DioException error) async {
    final response = error.response;
    if (response != null && response.statusCode == HttpStatus.notModified) {
      debugPrint(response.toString());
      return super.onError(error);
    }

    return super.onError(error);
  }
}
