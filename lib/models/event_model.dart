// To parse this JSON data, do
//
//     final eventModel = eventModelFromMap(jsonString);

import 'dart:convert';

class EventModel {
  EventModel({
    this.profile,
    this.id,
    required this.title,
    this.professionalName,
    this.patientName,
    required this.start,
    required this.end,
    required this.description,
    this.company,
    this.professional,
    this.patient,
  });

  int? profile;
  int? id;
  String title;
  dynamic professionalName;
  dynamic patientName;
  DateTime start;
  DateTime end;
  String description;
  dynamic company;
  dynamic professional;
  dynamic patient;

  factory EventModel.fromJson(String str) =>
      EventModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventModel.fromMap(Map<String, dynamic> json) => EventModel(
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
