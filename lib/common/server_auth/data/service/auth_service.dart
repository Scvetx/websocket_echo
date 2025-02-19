import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:websocket_echo/common/server_auth/data/service/auth_webservice.dart';

import '../../../../env/env.dart';

@injectable
class AuthService {
  AuthService(this._authWebService);
  final AuthWebService _authWebService;

  String? _token;
  int? _tokenExpiry; // Store expiration timestamp

  Future<String> getToken() async {
    await _refreshToken();
    return _token!;
  }
  
  Future<void> _fetchToken() async {
    final response = await _authWebService.login({
      'email': Env.wsLogin,
      'password': Env.wsPassword,
    });

    _token = response.token;
    _tokenExpiry = DateTime.now().millisecondsSinceEpoch + 3600000;  // Set expiry to 1 hour (3600000 ms)
    debugPrint("Token fetched successfully");
  }

  // Check if token is expired
  bool _isTokenExpired() {
    if (_tokenExpiry == null) {
      return true;
    }
    return DateTime.now().millisecondsSinceEpoch > _tokenExpiry!;
  }

  Future<void> _refreshToken() async {
    if (_isTokenExpired()) {
      await _fetchToken();  // Fetch new token if expired
    }
  }
}
