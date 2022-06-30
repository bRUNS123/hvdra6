import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:hydraflutter/models/user_model.dart';

class AuthService extends ChangeNotifier {
  //127.0.0.1:8000
  final String _baseURL = '10.0.2.2:8000';
  final storage = const FlutterSecureStorage();
  late UserInfoResponse userInfo = UserInfoResponse();
  late String emailRecordado;

  Future<String?> loginUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      "username": email,
      "password": password,
    };
    print(authData);
    final url = Uri.http(_baseURL, '/api/token/');
    final resp = await http.post(url, body: json.encode(authData), headers: {
      "Content-Type": "application/json",
    });
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('access')) {
      final String access = (decodedResp['access']);
      final String refresh = (decodedResp['refresh']);
      print(json.encode(authData));

      print('ACCESS: $access');
      print('REFRESH: $refresh');
      await storage.write(key: 'access', value: decodedResp['access']);
      await storage.write(key: 'refresh', value: decodedResp['refresh']);

      return null;
      //Guardar token en lugar seguro decodedResp['token'];

    } else {
      //arreglar
      // return decodedResp['errors']['param'];
      return 'Arreglar Error';
    }
  }

//Debo recibir el access también
  Future<String?> usernameInfo(String email) async {
    final String? access = await storage.read(key: 'access');
    final queryParameters = {
      'username': email,
    };
    var headers = {'Authorization': 'Bearer $access'};
    final url = Uri.http(_baseURL, '/profiles/get-username/', queryParameters);
    final resp = await http.get(url, headers: headers);
    final UserInfoResponse userDatos = UserInfoResponse.fromJson(resp.body);
    userInfo = userDatos;

    print(userInfo.firstName);

    notifyListeners();

    return '';
  }

  Future logout() async {
    await storage.delete(key: 'access');
    await storage.delete(key: 'refresh');
    userInfo = UserInfoResponse();

    notifyListeners();

    return;
  }

  Future<String> readToken() async {
    Map<String, dynamic> tokens;
    final access = await storage.read(key: 'access') ?? '';
    final refresh = await storage.read(key: 'refresh') ?? '';
    if (access == '' || refresh == '') {
      return '';
    }
    tokens = {'access': access, 'refresh': refresh};
    return json.encode(tokens);
  }

  Future<String?> userUpdate(UserUpdate userModel) async {
    final String? access = await storage.read(key: 'access');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access'
    };

    final url = Uri.http(_baseURL, '/profiles/1/');
    final resp =
        await http.patch(url, body: userModel.toJson(), headers: headers);
    print(resp.body);
    notifyListeners();
    return '';
  }
}




//Acceso y Refresh
//Access: 6 horas, Refresh: 12 horas
//Peticion con Access, se vence access, pedir nuevo con refresh.