import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/project.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;

  const ApiException(this.statusCode, this.message);

  @override
  String toString() => message;
}

class ApiClient {
  final http.Client _client;
  final String baseUrl;

  ApiClient({http.Client? client, String baseUrl = apiBaseUrl})
    : _client = client ?? http.Client(),
      baseUrl = baseUrl.replaceFirst(RegExp(r'/+$'), '');

  Uri _url(String path) => Uri.parse('$baseUrl$path');

  Map<String, String> _headers({String? token}) {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Token $token',
    };
  }

  void _checkResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    String message = 'Permintaan gagal (${response.statusCode}).';

    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (body is Map<String, dynamic>) {
        message = body['detail']?.toString() ?? jsonEncode(body);
      }
    } on FormatException {
      // Gunakan pesan umum jika respons bukan JSON.
    }

    throw ApiException(response.statusCode, message);
  }

  Future<List<Project>> fetchProjects() async {
    final response = await _client
        .get(_url('/api/v1/projects/'), headers: _headers())
        .timeout(const Duration(seconds: 20));

    _checkResponse(response);

    final data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

    return data
        .map((item) => Project.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Project> createProject(
    Project project, {
    required String token,
  }) async {
    final response = await _client
        .post(
          _url('/api/v1/projects/'),
          headers: _headers(token: token),
          body: jsonEncode(project.toJson()),
        )
        .timeout(const Duration(seconds: 20));

    _checkResponse(response);

    return Project.fromJson(
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
    );
  }

  Future<String> obtainToken({
    required String username,
    required String password,
  }) async {
    final response = await _client
        .post(
          _url('/api/v1/auth/token/'),
          headers: _headers(),
          body: jsonEncode({'username': username, 'password': password}),
        )
        .timeout(const Duration(seconds: 20));

    _checkResponse(response);

    final data =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    final token = data['token'];

    if (token is! String || token.isEmpty) {
      throw const ApiException(
        200,
        'Respons login tidak berisi token yang valid.',
      );
    }

    return token;
  }

  Future<void> logout(String token) async {
    final response = await _client
        .post(_url('/api/v1/auth/logout/'), headers: _headers(token: token))
        .timeout(const Duration(seconds: 20));

    _checkResponse(response);
  }

  void dispose() {
    _client.close();
  }
}
