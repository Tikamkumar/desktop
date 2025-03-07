import 'package:http/http.dart' as http;

class ApiService {
  static const String BASE_URL = 'https://battingtwoapi.indutechit.com/';

  Future<http.Response> signIn(Map<String ,String> header, Object body) async {
    return await http.post(Uri.parse('${BASE_URL}api/web/auth/login'), headers: header, body: body);
  }
  
  Future<http.Response> logout(Map<String, String> header) async {
    return await http.delete(Uri.parse('${BASE_URL}api/web/auth/logout'), headers: header);
  }

  Future<http.Response> createDealer(Map<String, String> header, Object body) async {
    return await http.post(Uri.parse('${BASE_URL}api/web/create/dealer'), headers: header, body: body);
  }

  Future<http.Response> createGame(Map<String, String> header, Object body) async {
    return await http.post(Uri.parse('${BASE_URL}api/web/create/game'), headers: header, body: body);
  }

  Future<http.Response> gameResult(Map<String, String> header, Object body, Map<String, dynamic> param) async {
    return await http.put(Uri.parse('${BASE_URL}api/web/update/gameResult').replace(queryParameters: param), headers: header, body: body);
  }

  Future<http.Response> deleteResult(Map<String, String> header, Map<String, dynamic> param) async {
    return await http.delete(Uri.parse('${BASE_URL}api/web/delete/gameResult').replace(queryParameters: param), headers: header);
  }

  Future<http.Response> createJantriBids(Map<String, String> header, Object body) async {
    return await http.post(Uri.parse('${BASE_URL}api/web/create/bids'), headers: header, body: body);
  }

  Future<http.Response> createStaff(Map<String, String> header, Object body) async {
    return await http.post(Uri.parse('${BASE_URL}api/web/create/staff'), headers: header, body: body);
  }

  Future<http.Response> getAllDealer(Map<String, String> header) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/dealers'), headers: header);
  }

  Future<http.Response> getAllOpenDealer(Map<String, String> header, Map<String, String> param) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/open-dealers').replace(queryParameters: param), headers: header);
  }

  Future<http.Response> getAllGames(Map<String, String> header, Map<String , String> param) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/games').replace(queryParameters: param), headers: header);
  }

  Future<http.Response> getBidById(Map<String, String> header, Map<String, String> param) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/bids').replace(queryParameters: param), headers: header);
  }

  Future<http.Response> getBidByDate(Map<String, String> header, Map<String, String> param) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/bids').replace(queryParameters: param), headers: header);
  }

  Future<http.Response> getSheetNo(Map<String, String> header,  Map<String, dynamic> param) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/sheet-number').replace(queryParameters: param), headers: header);
  }

  Future<http.Response> getAllSheet(Map<String, String> header,  Map<String, dynamic> param) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/sheets').replace(queryParameters: param), headers: header);
  }

  Future<http.Response> getRole(Map<String, String> header, Map<String, String> param) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/roles').replace(queryParameters: param), headers: header);
  }

  Future<http.Response> getAllStaff(Map<String, String> header) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/staff'), headers: header);
  }

  Future<http.Response> getDealerbyPage(Map<String, String> param, Map<String, String> header) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/dealers').replace(queryParameters: param), headers: header);
    // return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/dealers'), headers: header);
  }

  Future<http.Response> getStaffbyPage(Map<String, String> param, Map<String, String> header) async {
    return await http.get(Uri.parse('${BASE_URL}api/web/retrieve/staff').replace(queryParameters: param), headers: header);
  }

  Future<http.Response> updateDealer(Map<String, String> header, Object body, Map<String, dynamic> param) async {
    final response = await http.put(Uri.parse('${BASE_URL}api/web/update/dealer').replace(queryParameters: param),headers: header, body: body);
    return response;
  }

  Future<http.Response> deleteDealer(Map<String, String> header, Map<String, dynamic> param) async {
    final response = await http.delete(Uri.parse('${BASE_URL}api/web/delete/dealer').replace(queryParameters: param),headers: header);
    return response;
  }

  Future<http.Response> deleteGame(Map<String, String> header, Map<String, dynamic> param) async {
    return await http.delete(Uri.parse('${BASE_URL}api/web/delete/game').replace(queryParameters: param),headers: header);
  }

  Future<http.Response> updateGame(Map<String, String> header, Object body, Map<String, dynamic> param) async {
    return await http.put(Uri.parse('${BASE_URL}api/web/update/game').replace(queryParameters: param),headers: header, body: body);
  }

  Future<http.Response> updateStaff(Map<String, String> header, Object body, Map<String, dynamic> param) async {
    final response = await http.put(Uri.parse('${BASE_URL}api/web/update/staff').replace(queryParameters: param),headers: header, body: body);
    return response;
  }

  Future<http.Response> deleteStaff(Map<String, String> header, Map<String, dynamic> param) async {
    final response = await http.delete(Uri.parse('${BASE_URL}api/web/delete/user').replace(queryParameters: param),headers: header);
    return response;
  }
}