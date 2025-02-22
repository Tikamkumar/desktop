import 'dart:developer';

import 'package:betting/model/staff_model.dart';
import 'package:betting/repository/StaffRepository.dart';

class StaffViewModel {
  StaffRepository _repository = StaffRepository();

  Future<List<StaffModel>?> getAllStaff(Map<String, String> header) async {
    try {
      final response = _repository.getAllStaff(header);
      return response;
    } catch(exp) {
      log('Exception : ${exp.toString()}');
      return null;
    }
  }

  Future<List<StaffModel>?> getStaffByPage(Map<String, String> header,  Map<String, String> param) async {
    try {
      final response = await _repository.getStaffByPage(header, param);
      return response;
    } catch(exp) {
      log(exp.toString());
      return null;
    }
  }

  Future<String?> createStaff(Map<String, String> header, Object body) async {
    try {
      final response = _repository.createStaff(header, body);
      return response;
    } catch(exp) {
      log('Exception : ${exp.toString()}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getRole(Map<String, String> header, Map<String, String> param) async {
    try {
      final response = _repository.getRole(header, param);
      return response;
    } catch(exp) {
      log('Exception : ${exp.toString()}');
      return null;
    }
  }

  Future<String> updateStaff(Map<String, String> header,  Map<String, dynamic> param, Object body) async {
    try {
      final response = await _repository.updateStaff(header, body, param);
      log(response.toString());
      return response;
    } catch(exp) {
      log(exp.toString());
      return exp.toString();
    }
  }

  Future<String> deleteStaff(Map<String, String> header,  Map<String, dynamic> param) async {
    try {
      final response = await _repository.deleteStaff(header, param);
      log(response.toString());
      return response;
    } catch(exp) {
      log(exp.toString());
      return exp.toString();
    }
  }
}