import 'dart:convert';
import 'dart:developer';
import 'package:desktop/data/remote/api_service.dart';

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
    log(response.toString());
    if(response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body)['data']['dealers'];
      return List.generate(list.length, (index) => DealerModel.fromJson(list, index));
    } else {
      log(response.body);
      return null;
    }
  }

  Future<String> updateDealer(Map<String, String> header, Object body, Map<String, dynamic> param) async {
    final response = await _apiService.updateDealer(header, body, param);
    if(response.statusCode == 200) {
      return '200';
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  Future<String> deleteDealer(Map<String, String> header, Map<String, dynamic> param) async {
    final response = await _apiService.deleteDealer(header, param);
    if(response.statusCode == 200) {
      return '200';
    } else {
      return jsonDecode(response.body)['message'];
    }
  }
}