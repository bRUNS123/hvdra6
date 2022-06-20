import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/models.dart';

class EventService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  final String _baseURL = '10.0.2.2:8000';

  Future<String?> newEvent(EventModel eventModel) async {
    final String? access = await storage.read(key: 'access');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $access"
    };

    final url = Uri.http(_baseURL, '/events/');
    final resp =
        await http.post(url, body: eventModel.toJson(), headers: headers);
    print(access);
    print(resp.body);
    return '';
    //final resp = await http.get(url, headers: headers);
    // final Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(eventModel.end);
  }
}
