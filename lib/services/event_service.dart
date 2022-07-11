import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydraflutter/services/services.dart';

import '../models/models.dart';

class EventService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final String _baseURL = '10.0.2.2:8000';

  Future<List<Event>> getEventsById([int? id]) async {
    final String? access = await storage.read(key: 'access');

    print('idService: $id');
    //Pedir ID del patient.

    final queryParameters = {
      'patient_id': '$id',
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

  Future<String?> newEvent(Event eventModel) async {
    final String? access = await storage.read(key: 'access');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $access"
    };

    final url = Uri.http(_baseURL, '/events/');
    final resp =
        await http.post(url, body: eventModel.toJson(), headers: headers);

    if (resp.statusCode == 200) {
      NotificationsService.showSnackbar(
          'Se ha creado correctamente el evento.');
    }

    return '';
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
      NotificationsService.showSnackbar(
          'Se ha eliminado correctamente el evento: $id.');

      print(resp.body);
      // notifyListeners();
    }

    return '';
  }

  Future<String?> updateEvent(int id, EventUpdate eventModel) async {
    final String? access = await storage.read(key: 'access');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $access"
    };

    final url = Uri.http(_baseURL, '/events/$id/');
    final resp =
        await http.patch(url, body: eventModel.toJson(), headers: headers);
    if (resp.statusCode == 200) {
      NotificationsService.showSnackbar(
          'Se ha modificado correctamente el evento: $id.');
    }

    return '';
  }

  Future<List<GetProfessionalList>> getProfessionals(String query) async {
    final String? access = await storage.read(key: 'access');

    final queryParameters = {
      'is_professional': 'true',
    };
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $access"
    };
    final url = Uri.http(_baseURL, '/profiles/', queryParameters);

    try {
      final resp = await http.get(url, headers: headers);
      if (resp.statusCode == 200) {
        final List profesionales = json.decode(resp.body);
        return profesionales
            .map((json) => GetProfessionalList.fromJson(json))
            .where((profesionales) {
          // final id = profesionales.id;
          final nameLower = profesionales.fullName!.toLowerCase();
          final queryLower = query.toLowerCase();
          return nameLower.contains(queryLower);
        }).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
    }
    return [];

    // final List<Map<String, dynamic>> eventMap = EventModel.fromJson(decodeResp)
    // print(resultsMap);

    // final EventModel eventDatos = EventModel.fromJson(resp.body);
  }
}
