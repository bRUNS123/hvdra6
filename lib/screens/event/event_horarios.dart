import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydraflutter/models/date_event_model.dart';

import 'package:hydraflutter/widgets/custom_appbar.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:hydraflutter/utils/string_capitalize.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../services/services.dart';

class EventHorarios extends StatelessWidget {
  const EventHorarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final navigatorContext = Navigator.of(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Elige Horario'),
      body: FutureBuilder(
        future: readJson(),
        builder: (_, AsyncSnapshot<List<DateEventModel>> snapshot) {
          if (snapshot.hasData) {
            final horarios = snapshot.data;
            return Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: horarios!.length,
                    itemBuilder: (_, int i) {
                      return Column(children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[200],
                            ),
                            width: double.infinity,
                            height: size.height * 0.05,
                            child: Center(
                              child: Text(
                                DateFormat.yMMMMd('es_ES')
                                    .format(horarios[i].dia)
                                    .replaceAll('de', '')
                                    .toTitleCase(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.7,
                                  // childAspectRatio: 2.0,
                                  crossAxisSpacing: 25,
                                  mainAxisSpacing: 0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: horarios[i].horas!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () async {
                                      final eventProvider =
                                          Provider.of<EventFormProvider>(
                                              context,
                                              listen: false);
                                      final userProvider =
                                          Provider.of<AuthService>(context,
                                              listen: false);
                                      final eventService =
                                          Provider.of<EventService>(context,
                                              listen: false);
                                      await eventService.newEvent(Event(
                                        patient: userProvider.userInfo.id,
                                        professional: horarios[i]
                                            .profesionales![index]
                                            .professional,
                                        start:
                                            horarios[i].horas![index].timestart,
                                        end: horarios[i].horas![index].timeend,
                                      ));

                                      await eventProvider.refreshEvents(
                                          id: userProvider.userInfo.id);
                                      navigatorContext.pop();

                                      print(horarios[i]
                                          .profesionales![index]
                                          .professionalName);
                                      print(DateFormat('hh:mm a').format(
                                          horarios[i].horas![index].timestart));
                                      print('hola');
                                    },
                                    child: Container(
                                      height: size.height * 0.078,
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          left: 12,
                                          top: 12,
                                          bottom: 12,
                                          right: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black87,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.start,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${horarios[i].profesionales![index].professionalName}'
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          FittedBox(
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${DateFormat('hh:mm a').format(horarios[i].horas![index].timestart)} - ${DateFormat('hh:mm a').format(horarios[i].horas![index].timeend)}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ]);
                    }),
              ),
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }
}

Future<List<DateEventModel>> readJson() async {
  final String response = await rootBundle.loadString('data/eventexample.json');

  List<dynamic> responseData = await json.decode(response);
  List<Event> data = List.generate(
      responseData.length, (index) => Event.fromMap(responseData[index]));

  data.sort((a, b) => a.start.compareTo(b.start));
  List<DateEventModel> horario = [];
  print(data);

  for (var evenDate in data) {
    final dia = DateFormat.yMMMMd().format((evenDate.start));

    final existe = horario.indexWhere(
        (element) => DateFormat.yMMMMd().format(element.dia) == dia);

    if (existe == -1) {
      horario.add(DateEventModel(
        dia: evenDate.start,
        horas: [
          Hora(timestart: evenDate.start, timeend: evenDate.end),
        ],
        profesionales: [
          Professional(
              professional: evenDate.professional,
              professionalName: evenDate.professionalName)
        ],
      ));
      print(DateFormat('Hms').format(evenDate.start));

      // print('no existe un elemento : $existe');
    } else {
      horario[existe]
          .horas
          ?.add(Hora(timestart: evenDate.start, timeend: evenDate.end));
      horario[existe].profesionales?.add(Professional(
          professional: evenDate.professional,
          professionalName: evenDate.professionalName));
      print('${evenDate.start} ---- ${evenDate.end} ');
    }
  }
  return horario;
}
