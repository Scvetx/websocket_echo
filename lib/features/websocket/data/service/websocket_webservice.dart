import 'dart:async';
import 'dart:io';
import 'package:injectable/injectable.dart';
import '../../../../common/constants/app_const.dart';

@lazySingleton
class WebSocketWebService {
  /// Connects to WebSocket using the token
  Future<WebSocket> connectWebSocket(String token) async {
    return await WebSocket.connect(
      "${AppConst.WS_URL_PROD}?token=$token'}",
      headers: {AppConst.HEADER_AUTHORIZATION: "${AppConst.HEADER_PROTECTED_AUTHENTICATION_PREFIX} $token"},
    );
  }
  Future<WebSocket> connectWebSocketNoToken() async {
    return await WebSocket.connect(
      AppConst.WS_ECHO_PROD, // Connect to postman websocket which does not require token
    );
  }
}
