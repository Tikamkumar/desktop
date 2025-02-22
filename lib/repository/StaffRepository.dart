import 'dart:convert';
import 'dart:developer';

import 'package:betting/data/remote/api_service.dart';
import 'package:betting/model/dealer_model.dart';
import '../model/staff_model.dart';

class StaffRepository {
  ApiService _apiService = ApiService();

  Future<List<StaffModel>?> getAllStaff(Map<String, String> header) async {
    final response = await _apiService.getAllStaff(header);
    if(response.statusCode == 200) {
      final list = jsonDecode(response.body)['data']['users'];
      return List.generate(list.length, (index) => StaffModel.fromJson(list, index));
    } else {
      return null;
    }
  }

  Future<List<StaffModel>?> getStaffByPage(Map<String, String> header, Map<String, String> param) async {
    final response = await _apiService.getStaffbyPage(param, header);
    log(response.toString());
    if(response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body)['data']['users'];
      log(response.body);
      return List.generate(list.length, (index) => StaffModel.fromJson(list, index));
    } else {
      log(response.body);
      return null;
    }
  }

  Future<String> updateStaff(Map<String, String> header, Object body, Map<String, dynamic> param) async {
    final response = await _apiService.updateStaff(header, body, param);
    if(response.statusCode == 200) {
      return '200';
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  Future<String> deleteStaff(Map<String, String> header, Map<String, dynamic> param) async {
    final response = await _apiService.deleteStaff(header, param);
    if(response.statusCode == 200) {
      return '200';
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  Future<String?> createStaff(Map<String, String> header, Object body) async {
    final response = await _apiService.createStaff(header, body);
    if(response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getRole(Map<String, String> header, Map<String, String> param) async {
    final response = await _apiService.getRole(header, param);
    log(response.body.toString());
    if(response.statusCode == 200) {
      final list = jsonDecode(response.body)['data'];
      return {'name': list[0]['name'], 'id': list[0]['id']};
    } else {
      return null;
    }
  }
}