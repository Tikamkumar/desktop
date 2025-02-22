
import 'dart:developer';

import 'package:betting/repository/DealerRepository.dart';

import '../model/dealer_model.dart';

class DealerViewModel {
  final DealerRepository _dealerRepository = DealerRepository();

  Future<String> createDealer(Map<String, String> header, Object body) async {
    try {
      final response = await _dealerRepository.createDealer(header, body);
      return response.toString();
    } catch(exp) {
      print(exp.toString());
      return 'null';
    }
  }

  Future<List<DealerModel>?> getAllDealers(Map<String, String> header) async {
    try {
      final response = await _dealerRepository.getAllDealer(header);
      return response;
    } catch(exp) {
      log(exp.toString());
      return null;
    }
  }

  Future<List<Map<String, String>>?> getAllOpenDealers(Map<String, String> header, Map<String, String> param) async {
    try {
      final response = await _dealerRepository.getAllOpenDealer(header, param);
      log("Response : "+ response.toString());
      return response;
    } catch(exp) {
      log(exp.toString());
      return null;
    }
  }

  Future<List<DealerModel>?> getDealerByName(Map<String, String> header,  Map<String, String> param) async {
    try {
      final response = await _dealerRepository.getDealerByPage(header, param);
      return response;
    } catch(exp) {
      log(exp.toString());
      return null;
    }
  }

  Future<String> updateDealer(Map<String, String> header,  Map<String, dynamic> param, Object body) async {
    try {
      final response = await _dealerRepository.updateDealer(header, body, param);
      log(response.toString());
      return response;
    } catch(exp) {
      log(exp.toString());
      return exp.toString();
    }
  }

  Future<String> deleteDealer(Map<String, String> header,  Map<String, dynamic> param) async {
    try {
      final response = await _dealerRepository.deleteDealer(header, param);
      log(response.toString());
      return response;
    } catch(exp) {
      log(exp.toString());
      return exp.toString();
    }
  }
}