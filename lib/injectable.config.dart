// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:websocket_echo/common/server_auth/data/repository/auth_repository.dart'
    as _i202;
import 'package:websocket_echo/common/server_auth/data/service/auth_service.dart'
    as _i374;
import 'package:websocket_echo/common/server_auth/data/service/auth_webservice.dart'
    as _i810;
import 'package:websocket_echo/features/websocket/data/repository/websocket_repository.dart'
    as _i668;
import 'package:websocket_echo/features/websocket/data/service/websocket_service.dart'
    as _i14;
import 'package:websocket_echo/features/websocket/data/service/websocket_webservice.dart'
    as _i41;
import 'package:websocket_echo/infrastructure/injectable/injectable.module.dart'
    as _i84;
import 'package:websocket_echo/infrastructure/interceptors/combining_smart_interceptor.dart'
    as _i599;
import 'package:websocket_echo/infrastructure/interceptors/network_auth_interceptor.dart'
    as _i527;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.singleton<_i527.NetworkAuthInterceptor>(
        () => _i527.NetworkAuthInterceptor());
    gh.lazySingleton<_i41.WebSocketWebService>(
        () => _i41.WebSocketWebService());
    gh.lazySingleton<_i14.WebSocketService>(
        () => _i14.WebSocketService(gh<_i41.WebSocketWebService>()));
    gh.singleton<_i599.CombiningSmartInterceptor>(() => injectableModule
        .provideCombiningSmartInterceptor(gh<_i527.NetworkAuthInterceptor>()));
    gh.singleton<_i361.Dio>(
        () => injectableModule.dio(gh<_i599.CombiningSmartInterceptor>()));
    gh.lazySingleton<_i810.AuthWebService>(
        () => _i810.AuthWebService(gh<_i361.Dio>()));
    gh.factory<_i374.AuthService>(
        () => _i374.AuthService(gh<_i810.AuthWebService>()));
    gh.lazySingleton<_i202.AuthRepository>(
        () => _i202.AuthRepository(gh<_i374.AuthService>()));
    gh.lazySingleton<_i668.WebSocketRepository>(() => _i668.WebSocketRepository(
          gh<_i202.AuthRepository>(),
          gh<_i14.WebSocketService>(),
        ));
    return this;
  }
}

class _$InjectableModule extends _i84.InjectableModule {}
