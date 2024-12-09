
import 'dart:developer';

import 'package:desktop/repository/DealerRepository.dart';

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

  Future<List<DealerModel>?> getDealerByName(Map<String, String> header,  Map<String, String> param) async {
    try {
      final response = await _dealerRepository.getDealerByPage(header, param);
      return response;
    } catch(exp) {
      log(exp.toString());
      return null;
    }
  }
}