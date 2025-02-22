import 'dart:convert';
import 'dart:developer';
import 'package:betting/data/remote/api_service.dart';
import 'package:betting/model/bid_model.dart';
import 'package:http/http.dart' as http;
import '../model/game_model.dart';

class Gamerepository {
  final ApiService _apiService = ApiService();

  Future<String> createGame(Map<String, String> header, Object body) async {
    final response = await _apiService.createGame(header, body);
    if(response.statusCode == 200  && jsonDecode(response.body)['type'] == 'success') {
      return jsonDecode(response.body)['message'];
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  Future<String> gameResult(Map<String, String> header, Object body, Map<String, dynamic> param) async {
    final response = await _apiService.gameResult(header, body, param);
    log(response.body.toString());
    if(response.statusCode == 200 && jsonDecode(response.body)['type'] == 'success') {
      return '200';
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  Future<String?> deleteResult(Map<String, String> header, Map<String, String> param) async {
    final response = await _apiService.deleteResult(header, param);
    log(response.body.toString());
    if(response.statusCode == 200) {
      return '200';
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  Future<String?> deleteGame(Map<String, String> header, Map<String, dynamic> param) async {
    final response = await _apiService.deleteGame(header, param);
    log('Game Delete Response : ${response.statusCode.toString()}');
    log(response.body.toString());
    if(response.statusCode == 200) {
      return '200';
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  Future<String?> updateGame(Map<String, String> header, Map<String, dynamic> param, Object body) async {
    final response = await _apiService.updateGame(header, body, param);
    log('Response : ${response.body}');
    if(response.statusCode == 201 || response.statusCode == 200) {
      return '${response.statusCode}';
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  Future<List<GameModel>?> getAllGame(Map<String, String> header, Map<String , String> param) async {
    final response = await _apiService.getAllGames(header, param);
    log('Game Response : '+ response.toString());
    if(response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body)['data']['games'];
      return List.generate(list.length, (index) => GameModel.fromJson(list, index));
    } else {
      log(response.body);
      return null;
    }
  }

  Future<Map<String, dynamic>?> getSheetNo(Map<String, String> header, Map<String, dynamic> param) async {
    final response = await _apiService.getSheetNo(header, param);
    if(response.statusCode == 200) {
      return {'sheetNo': jsonDecode(response.body)['data']['sheetNumber']['sheetNo'].toString()};
    } else {
      log(response.body);
      return null;
    }
  }

  Future<http.Response?> getAllSheet(Map<String, String> header, Map<String, dynamic> param) async {
    final response = await _apiService.getAllSheet(header, param);
    if(response.statusCode == 200) {
      return response;
    } else {
      log(response.body);
      return null;
    }
  }

  Future<BidModel?> getBidById(Map<String, String> header, Map<String, String> param) async {
    final response = await _apiService.getBidById(header, param);
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return BidModel(data['inside'], data['outside'], data['bids'], data['finalBidNumber'], data['collectedAmount']);
    } else {
      return null;
    }
  }

  Future<http.Response?> getBidByDate(Map<String, String> header, Map<String, String> param) async {
    final response = await _apiService.getBidByDate(header, param);
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return response;
    } else {
      return null;
    }
  }

  Future<String?> createJantriBids(Map<String, String> header, Object body) async {
    final response = await _apiService.createJantriBids(header, body);
    if(response.statusCode == 201) {
      if(jsonDecode(response.body)['type'] == 'success') {
        return '201';
      } else {
        return response.body.toString();
      }
    } else {
      return response.body.toString();
    }
  }
}