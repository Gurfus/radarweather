import 'package:flutter/material.dart';
import 'package:radarweather/model/aemetWeather/hourly/weather_hourly_aemet.dart';

import '../../model/aemetWeather/hourly/estado_cielo.dart';
import '../../model/aemetWeather/hourly/temperatura.dart';

getSortHours(WeatherHourlyAemet weatherHourlyAemet) {
  DateTime now = DateTime.now();
  now = DateTime(now.year, now.month, now.day, now.hour, 0);

  List<Temperatura> allTemperaturas = [];
  List<EstadoCielo> allEstadoCielo = [];

  for (var dia in weatherHourlyAemet.prediccion?.dia ?? []) {
    List<dynamic>? temperaturas = dia.temperatura?.map((e) => e).toList();
    List<dynamic>? cielo = dia.estadoCielo?.map((e) => e).toList();
    DateTime fecha = DateTime.parse(dia.fecha!);

    for (int i = 0; i < temperaturas!.length; i++) {
      int hour = int.parse(temperaturas.elementAt(i).periodo!);
      var h = TimeOfDay(hour: hour, minute: 0);

      DateTime currentDateTime = DateTime(
        fecha.year,
        fecha.month,
        fecha.day,
        h.hour,
        h.minute,
      );

      if (currentDateTime.isBefore(now)) {
        continue; // Omitir si la hora actual es anterior a la hora de la iteración
      }

      if ((dia == weatherHourlyAemet.prediccion?.dia?.first &&
              ((currentDateTime.isAfter(now) && now.day == fecha.day) ||
                  (currentDateTime.isAfter(DateTime(0, 0, 0)) &&
                      now.day != fecha.day))) ||
          (dia != weatherHourlyAemet.prediccion?.dia?.first)) {
        if (currentDateTime.hour == 20) {
          fecha = fecha.add(const Duration(days: 1));
        }
        if (currentDateTime.isBefore(now) && now.day == fecha.day) {
          continue;
        }

        Temperatura temperatura = Temperatura(
          periodo: temperaturas.elementAt(i).periodo,
          value: temperaturas.elementAt(i).value,
        );

        if (int.parse(cielo?.elementAt(0).periodo) !=
            int.parse(temperaturas.elementAt(0).periodo)) {
          cielo?.removeAt(0);
        }

        EstadoCielo estadoCielo = EstadoCielo(
          periodo: cielo?.elementAt(i).periodo,
          value: cielo?.elementAt(i).value,
          descripcion: cielo?.elementAt(i).descripcion,
        );

        allTemperaturas.add(temperatura);
        allEstadoCielo.add(estadoCielo);
      }
    }
  }

  return [allEstadoCielo, allTemperaturas];
}
