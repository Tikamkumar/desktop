import 'dart:convert';

import 'package:desktop/data/remote/ApiService.dart';
import 'package:desktop/model/dealer_model.dart';
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
}