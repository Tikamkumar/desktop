import 'dart:developer';
import 'package:betting/repository/UserRepository.dart';
import 'package:flutter/material.dart';

class UserViewModel  {
  final UserRepository _userRepository = UserRepository();

  Future<Map<String, dynamic>> signIn(Map<String, String> header, Object body) async {
    try {
      final response = _userRepository.signIn(header, body);
      log('User View Model Success');
      return response;
    } catch(exp) {
      log('User View Model failed');
      return {'error': exp.toString()};
    }
  }

  Future<String> logout(Map<String, String> header) async {
    try {
      final response = await _userRepository.logout(header);
      return response;
    } catch(exp) {
      return exp.toString();
    }
  }
}