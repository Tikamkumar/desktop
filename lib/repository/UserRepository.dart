
import 'dart:convert';
import 'dart:developer';
import 'package:betting/data/remote/api_service.dart';

class UserRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> signIn(Map<String, String> header, Object body) async {
    final response = await _apiService.signIn(header, body);
    if(response.statusCode == 200 && jsonDecode(response.body)['type'] == 'success') {
      log('User Repository success');
      return {'token': jsonDecode(response.body)['data']['token'], 'role': jsonDecode(response.body)['data']['user']['roleSlug'], 'id': jsonDecode(response.body)['data']['user']['id']};
    } else {
      log('User Repository failed');
      return {'error': jsonDecode(response.body)['message']};
    }
  }

  Future<String> logout(Map<String, String> header) async {
    final response = await _apiService.logout(header);
    if(response.statusCode == 200) {
      return jsonDecode(response.body)['type'];
    } else {
      return jsonDecode(response.body)['message'];
    }
  }
}