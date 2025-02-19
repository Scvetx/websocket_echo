import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../const/message_type_const.dart';
import '../../models/websocket_message.dart';
import 'websocket_webservice.dart';

@lazySingleton
class WebSocketService {
  WebSocketService(this._webSocketWebservice);
  final WebSocketWebService _webSocketWebservice;

  WebSocket? _socket;
  StreamController<WebSocketMessage>? _controller;

  /// true if websocket is connected
  bool isConnected = false;
  /// Stream of incoming messages from WebSocket
  Stream<WebSocketMessage> get messageStream => _controller!.stream;
  String? _token;
  

  /// Connects to WebSocket using the token
  /// and starts broadcasting messages
  Future<bool> start(String token) async {
    _token = token;
    try {
      _socket = await _webSocketWebservice.connectWebSocket(token);
      await _startBroadcasting();
      return true;
    } catch (e) {
      debugPrint('Error starting websocket: $e');
      return false;
    }
  }

  /// Connects to WebSocket using the token
  /// and starts broadcasting messages
  Future<bool> startNoToken() async {
    try {
      _socket = await _webSocketWebservice.connectWebSocketNoToken();
      await _startBroadcasting();
      return true;
    } catch (e) {
      debugPrint('Error starting websocket: $e');
      return false;
    }
  }

  /// Sends a message to the WebSocket
  void sendMessage(WebSocketMessage message) {
    if (_socket != null && _socket!.readyState == WebSocket.open) {
      _socket!.add(jsonEncode(message.toJson()));
      debugPrint("📤 Sent: ${message.toJson()}");
    } else {
      debugPrint("❌ WebSocket is not connected.");
    }
  }

  /// Closes the WebSocket connection
  void closeConnection() {
    isConnected = false;
    _socket?.close();
    _controller?.close();
    _socket = null;
    debugPrint("🚪 WebSocket Connection Closed");
  }

    /// Closes the WebSocket connection
  Future<void> _restartConnection() async{
    isConnected = false;
    _socket?.close();
    _socket = null;
    if(_token == null) {
      await startNoToken();
    } else {
      await start(_token!);
    }
    debugPrint("🚪 WebSocket Connection Restarted");
  }

  /// Start broadcasting messages
  Future<void> _startBroadcasting() async {
    _controller ??= StreamController<WebSocketMessage>.broadcast();

    _socket!.listen((message) {
      try {
        // chat message in JSON format
        final wsMessage = WebSocketMessage.fromJson(jsonDecode(message as String));
        _controller!.add(wsMessage);
      } catch (e) {
        // system message in String format
        final wsMessage = WebSocketMessage(type: MessageTypeConst.system, content: message as String);
        _controller!.add(wsMessage);
      }
      debugPrint("📩 Received: $message");

    }, onError: (error) {
      debugPrint("❌ WebSocket Error: $error");
    }, onDone: () async {
      debugPrint("⚠️ WebSocket Disconnected");
      _restartConnection();
    });
    isConnected = true;

    debugPrint("✅ WebSocket Connected!");
  }
}