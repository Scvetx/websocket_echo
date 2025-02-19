import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/server_auth/data/repository/auth_repository.dart';
import '../../models/websocket_message.dart';
import '../service/websocket_service.dart';

@lazySingleton
class WebSocketRepository {
  WebSocketRepository(
    this._authRepo,
    this._webSocketService,
  );

  final AuthRepository _authRepo;
  final WebSocketService _webSocketService;

  /// Fetches the token and starts receiving WebSocket messages
  Future<bool> start() async {
    try {
      final token = await _authRepo.getToken();
      if(token == null) {
        throw Exception("Token is null");
      }
      final isSuccess = await _webSocketService.start(token);
      return isSuccess;
    } catch (e) {
      debugPrint('Error starting websocket: $e');
      return false;
    }
  }

  // connect to postman websocket which does not require token
  Future<bool> startNoToken() async {
    try {
      final isSuccess = await _webSocketService.startNoToken();
      return isSuccess;
    } catch (e) {
      debugPrint('Error starting websocket: $e');
      return false;
    }
  }

  /// Sends a message to the WebSocket
  void sendMessage(WebSocketMessage message) {
    try {
      _webSocketService.sendMessage(message);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  /// Closes the WebSocket connection
  /// and stops receiving messages
  void closeConnection() {
    try {
      _webSocketService.closeConnection();
    } catch (e) {
      debugPrint('Error closing websocket: $e');
    }
  }

  /// Stream of incoming messages from WebSocket
  /// Use this to listen to incoming messages
  Stream<WebSocketMessage> get messageStream => _webSocketService.messageStream;
}