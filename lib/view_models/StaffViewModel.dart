import 'dart:developer';

import 'package:desktop/model/staff_model.dart';
import 'package:desktop/repository/StaffRepository.dart';

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
}