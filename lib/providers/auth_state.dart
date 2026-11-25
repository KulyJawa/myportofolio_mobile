import 'package:flutter/foundation.dart';

import '../services/api_client.dart';

class AuthState extends ChangeNotifier {
  final ApiClient _api;
  String? _token;

  AuthState(this._api);

  String? get token => _token;
  bool get isLoggedIn => _token != null;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    _token = await _api.obtainToken(username: username, password: password);
    notifyListeners();
  }

  Future<void> logout() async {
    final currentToken = _token;

    try {
      if (currentToken != null) {
        await _api.logout(currentToken);
      }
    } finally {
      _token = null;
      notifyListeners();
    }
  }
}
