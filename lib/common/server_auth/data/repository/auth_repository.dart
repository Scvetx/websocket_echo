import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../service/auth_service.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._authService);
  final AuthService _authService;

  Future<String?> getToken() async {
    try {
      return await _authService.getToken();
    } catch (e) {
      debugPrint("Error fetching token: $e");
      return null;
    }
  }
}
