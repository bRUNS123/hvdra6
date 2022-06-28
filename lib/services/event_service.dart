import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/models.dart';

class EventService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final String _baseURL = '10.0.2.2:8000';

  Future<String?> newEvent(Event eventModel) async {
    final String? access = await storage.read(key: 'access');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $access"
    };

    final url = Uri.http(_baseURL, '/events/');
    final resp =
        await http.post(url, body: eventModel.toJson(), headers: headers);

    print(resp.body);
    return '';
  }

  Future<List<Event>> getEventsById() async {
    final String? access = await storage.read(key: 'access');
    const int userId = 1;

    final queryParameters = {
      'patient_id': '1',
    };
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $access"
    };
    final url = Uri.http(_baseURL, '/events/', queryParameters);

    try {
      final resp = await http.get(url, headers: headers);
      if (resp.statusCode == 200) {
        final decodeResp = await json.decode(resp.body);
        print(resp.body);
        var listEvent = <Event>[];
        for (var eventModel in decodeResp) {
          var e1 = Event.fromMap(eventModel);
          listEvent.add(e1);
        }
        print(resp.body);

        return listEvent;
      }
      return [];
    } catch (e) {
      print(e);
    }
    return [];

    // final List<Map<String, dynamic>> eventMap = EventModel.fromJson(decodeResp)
    // print(resultsMap);

    // final EventModel eventDatos = EventModel.fromJson(resp.body);
  }

  Future<String?> deleteEvent(int id) async {
    final String? access = await storage.read(key: 'access');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $access"
    };

    final url = Uri.http(_baseURL, '/events/$id/');
    final resp = await http.delete(url, headers: headers);
    if (resp.statusCode == 200) {
      print('Se ha eliminado correctamente el evento: $id');

      print(resp.body);
    }

    return '';
  }

  Future<String?> updateEvent(int id, EventUpdate eventModel) async {
    final String? access = await storage.read(key: 'access');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $access"
    };

    print('START: ${eventModel.start}');
    print('END: ${eventModel.end}');
    print('PROFESSIONAL: ${eventModel.professional}');

    final url = Uri.http(_baseURL, '/events/$id/');
    final resp =
        await http.patch(url, body: eventModel.toJson(), headers: headers);
    if (resp.statusCode == 200) {
      print('Se ha modificado correctamente el evento: $id');

      print(resp.body);
    }

    return '';
  }
}
