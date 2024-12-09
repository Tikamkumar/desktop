import 'dart:convert';
import 'dart:developer';
import 'package:desktop/data/remote/ApiService.dart';

import '../home_tabs/user/dealer.dart';
import '../model/dealer_model.dart';

class DealerRepository {
  final ApiService _apiService = ApiService();

  Future<String> createDealer(Map<String, String> header, Object body) async {
    final response = await _apiService.createDealer(header, body);
    if(response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  Future<List<DealerModel>?> getAllDealer(Map<String, String> header) async {
    final response = await _apiService.getAllDealer(header);
    if(response.statusCode == 200) {
       List<dynamic> list = jsonDecode(response.body)['data']['dealers'];
       return List.generate(list.length, (index) => DealerModel.fromJson(list, index));
    } else {
      log(response.body);
      return null;
    }
  }

  Future<List<DealerModel>?> getDealerByPage(Map<String, String> header, Map<String, String> param) async {
    final response = await _apiService.getDealerbyPage(param, header);
    if(response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body)['data']['dealers'];
      return List.generate(list.length, (index) => DealerModel.fromJson(list, index));
    } else {
      log(response.body);
      return null;
    }
  }
}