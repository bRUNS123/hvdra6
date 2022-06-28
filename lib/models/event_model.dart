// To parse this JSON data, do
//
//     final eventModel = eventModelFromMap(jsonString);

import 'dart:convert';

class Event {
  Event({
    this.profile,
    this.id,
    this.title,
    this.professionalName,
    this.patientName,
    required this.start,
    required this.end,
    this.description,
    this.company,
    this.professional,
    required this.patient,
  });

  int? profile;
  int? id;
  String? title;
  String? professionalName;
  String? patientName;
  DateTime start;
  DateTime end;
  String? description;
  String? company;
  int? professional;
  int? patient;

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        profile: json["profile"],
        id: json["id"],
        title: json["title"],
        professionalName: json["professional_name"],
        patientName: json["patient_name"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        description: json["description"],
        company: json["company"],
        professional: json["professional"],
        patient: json["patient"],
      );

  Map<String, dynamic> toMap() => {
        "profile": profile,
        "id": id,
        "title": title,
        "professional_name": professionalName,
        "patient_name": patientName,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "description": description,
        "company": company,
        "professional": professional,
        "patient": patient,
      };
}

// To parse this JSON data, do
//
//     final editUpdate = editUpdateFromMap(jsonString);

class EventUpdate {
  EventUpdate({
    required this.professional,
    required this.start,
    required this.end,
  });

  int professional;
  DateTime start;
  DateTime end;

  EventUpdate copyWith({
    int? professional,
    DateTime? start,
    DateTime? end,
  }) =>
      EventUpdate(
        professional: professional ?? this.professional,
        start: start ?? this.start,
        end: end ?? this.end,
      );

  factory EventUpdate.fromJson(String str) =>
      EventUpdate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventUpdate.fromMap(Map<String, dynamic> json) => EventUpdate(
        professional: json["professional"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toMap() => {
        "professional": professional,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
      };
}
