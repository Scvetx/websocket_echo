// ignore_for_file: unnecessary_question_mark

import 'dart:async';

import 'package:dio/dio.dart';

/// Base class for simple [Dio] interceptors to be used in conjunction with
/// [CombiningSmartInterceptor].
///
/// Upon returning an instance of [DioException] from [onRequest] or [onResponse],
/// the error interceptors will NOT be called
abstract class SimpleInterceptor {
  /// Called when the interceptor should process the request ([options])
  ///
  /// Return a future with (modified) [RequestOptions] to continue the chain
  /// or an instance of [DioException] (or subclasses) to halt processing.
  ///
  /// Any other values will simply call the next interceptor with [options]
  Future<Object?> onRequest(RequestOptions options) {
    return Future.value(options);
  }

  /// Return a future with (modified) [RequestOptions] to continue the chain
  /// or an instance of [DioException] (or subclasses) to halt processing.
  ///

  Future<Object?> onResponse(Response response) {
    return Future.value(response);
  }

  /// Called when the interceptor should process an [error]
  ///
  /// Return a future with (modified) [DioException] to continue the chain
  /// or an instance of [Response] (or subclasses) to halt processing and
  /// mark the request as successful. NOTE: When returning [Response], no other
  /// interceptors will be called.
  ///
  /// Any other values will simply call the next interceptor with [error]
  Future<Object?> onError(DioException error) {
    return Future.value(error);
  }
}

/// Dio [Interceptor] implementation which calls the interceptors in the logical
/// order (request in the interceptor order, responses and errors in the reverse
/// order)
class CombiningSmartInterceptor implements Interceptor {
  final _interceptors = <SimpleInterceptor>[];

  /// Constructor taking an optional [initial] collection of interceptors to
  /// pre-fill the interceptors
  CombiningSmartInterceptor([Iterable<SimpleInterceptor>? initial]) {
    if (initial != null) {
      _interceptors.addAll(initial);
    }
  }

  /// Adds an interceptor at the end of the chain (called LAST)
  void addInterceptor(SimpleInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    //bool internetConnected = await ConnectivityManager.checkInternetConnection();
    //if (!internetConnected) return;
    
    dynamic? finalResult;
    for (final interceptor in _interceptors.reversed) {
      try {
        final dynamic res = await interceptor
            .onError(finalResult is DioException ? finalResult : err);
        if (res is Response) {
          handler.resolve(res);
          return;
        }
      } on DioException catch (e) {
        handler.next(e);
        return;
      } catch (e) {
        handler.next(DioException(requestOptions: err.requestOptions, error: e));
        return;
      }
    }
    handler.next(finalResult ?? err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // bool internetConnected = await ConnectivityManager.checkInternetConnection();
    // if (!internetConnected) return;

    var intermediate = options;
    for (final interceptor in _interceptors) {
      try {
        final dynamic res = await interceptor.onRequest(intermediate);
        if (res is RequestOptions) {
          intermediate = res;
          continue;
        } else if (res is DioException) {
          handler.reject(res, false);
          return;
        }
      } on DioException catch (e) {
        handler.reject(e, false);
        return;
      } catch (e) {
        handler.reject(DioException(requestOptions: options, error: e));
        return;
      }
    }
    handler.next(intermediate);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    var intermediate = response;
    for (final interceptor in _interceptors.reversed) {
      try {
        final dynamic res = await interceptor.onResponse(intermediate);
        if (res is Response) {
          intermediate = res;
          continue;
        } else if (res is DioException) {
          handler.reject(res, false);
          return;
        }
      } on DioException catch (e) {
        handler.reject(e, false);
        return;
      } catch (e) {
        handler.reject(
          DioException(requestOptions: response.requestOptions, error: e),
        );
        return;
      }
    }
    handler.next(intermediate);
  }
}
