import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:betting/repository/GameRepository.dart';
import '../model/bid_model.dart';
import '../model/game_model.dart';

class GameViewModel {
  Gamerepository respository = Gamerepository();

  Future<List<GameModel>?> getAllGames(Map<String, String> header, Map<String, String> param) async {
    try {
       final response = await respository.getAllGame(header, param);
       return response;
    } catch(exp) {
      log(exp.toString());
       return null;
    }
  }

  Future<BidModel?> getBidById(Map<String, String> header, Map<String, String> param) async {
    try {
       final response = await respository.getBidById(header, param);
       return response;
    } catch(exp) {
       log(exp.toString());
    }
  }

  Future<http.Response?> getBidByDate(Map<String, String> header, Map<String, String> param) async {
    try {
      final response = await respository.getBidByDate(header, param);
      return response;
    } catch(exp) {
      log(exp.toString());
    }
  }

  Future<String?> createJantriBids(Map<String, String> header, Object body) async {
    String? response = '';
    try {
      response = await respository.createJantriBids(header, body);
      return response;
    } catch(exp) {
      return response;
    }
  }

  Future<String?> updateGame(Map<String, String> header, Object body, Map<String, dynamic> param) async {
    try {
      final response = await respository.updateGame(header, param, body);
      return response;
    } catch(exp) {
      return null;
    }
  }

  Future<String> createGame(Map<String, String> header, Object body) async {
    try {
      final response = await respository.createGame(header, body);
      return response;
    } catch(exp) {
      return 'Something went wrong..';
    }
  }

  Future<String> gameResult(Map<String, String> header, Object body, Map<String, dynamic> param) async {
    try {
      final response = await respository.gameResult(header, body, param);
      return response;
    } catch(exp) {
      return 'Something went wrong..';
    }
  }

  Future<String?> deleteResult(Map<String, String> header, Map<String, String> param) async {
    try {
      final response = await respository.deleteResult(header, param);
      log(response.toString());
      return response;
    } catch(exp) {
      log(exp.toString());
      return null;
    }
  }

  Future<String?> deleteGame(Map<String, String> header, Map<String, dynamic> param) async {
    try {
      final response = await respository.deleteGame(header, param);
      log(response.toString());
      return response;
    } catch(exp) {
      log(exp.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> getSheetNo(Map<String, String> header, Map<String, dynamic> param) async {
    try {
      final response = await respository.getSheetNo(header, param);
      return response;
    } catch(exp) {
      return null;
    }
  }

  Future<http.Response?> getAllSheet(Map<String, String> header, Map<String, dynamic> param) async {
    try {
      final response = await respository.getAllSheet(header, param);
      return response;
    } catch(exp) {
      return null;
    }
  }
}