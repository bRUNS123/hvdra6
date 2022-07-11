// To parse this JSON data, do
//
//     final dateEventModel = dateEventModelFromMap(jsonString);

import 'dart:convert';

List<DateEventModel> dateEventModelFromMap(String str) =>
    List<DateEventModel>.from(
        json.decode(str).map((x) => DateEventModel.fromMap(x)));

String dateEventModelToMap(List<DateEventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DateEventModel {
  DateEventModel({
    required this.dia,
    this.horas,
    this.profesionales,
  });

  DateTime dia;
  List<Hora>? horas;
  List<Professional>? profesionales;

  factory DateEventModel.fromMap(Map<String, dynamic> json) => DateEventModel(
        dia: DateTime.parse(json["dia"]),
        horas: List<Hora>.from(json["horas"].map((x) => Hora.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "dia": dia.toIso8601String(),
        "horas": List<dynamic>.from(horas!.map((x) => x.toMap())),
      };
}

class Hora {
  Hora({
    required this.timestart,
    required this.timeend,
  });

  DateTime timestart;
  DateTime timeend;

  factory Hora.fromMap(Map<String, dynamic> json) => Hora(
        timestart: DateTime.parse(json["timestart"]),
        timeend: DateTime.parse(json["timeend"]),
      );

  Map<String, dynamic> toMap() => {
        "timestart": timestart.toIso8601String(),
        "timeend": timeend.toIso8601String(),
      };
}

class Professional {
  Professional({
    this.professional,
    this.professionalName,
  });

  int? professional;
  String? professionalName;

  factory Professional.fromMap(Map<String, dynamic> json) => Professional(
        professional: json["professional"],
        professionalName: json["professional_name"],
      );

  Map<String, dynamic> toMap() => {
        "professional": professional,
        "professional_name": professionalName,
      };
}
