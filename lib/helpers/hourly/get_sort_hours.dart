import 'package:flutter/material.dart';
import 'package:radarweather/model/aemetWeather/hourly/weather_hourly_aemet.dart';

import '../../model/aemetWeather/hourly/estado_cielo.dart';
import '../../model/aemetWeather/hourly/temperatura.dart';

getSortHours(WeatherHourlyAemet weatherHourlyAemet) {
  DateTime now = DateTime.now();
  now.hour;

  List<Temperatura> allTemperaturas = [];
  List<EstadoCielo> allEstadoCielo = [];

  for (var dia in weatherHourlyAemet.prediccion?.dia ?? []) {
    List<dynamic>? temperaturas = dia.temperatura?.map((e) => e).toList();
    List<dynamic>? cielo = dia.estadoCielo?.map((e) => e).toList();
    //print(horas);

    for (int i = 0; i < temperaturas!.length; i++) {
      int hour = int.parse(temperaturas.elementAt(i).periodo!);
      var h = TimeOfDay(hour: hour, minute: 0);
      DateTime fecha = DateTime.parse(dia.fecha!);

      // Si es el primer día y la hora es menor o igual a la hora actual,
      // o si es un día posterior, se agregan las horas a la lista
      if ((dia == weatherHourlyAemet.prediccion?.dia?.first &&
              (hour > now.hour || now.hour == 0)) ||
          (dia != weatherHourlyAemet.prediccion?.dia?.first) &&
              (hour > now.hour)) {
        // Si es a partir de las 23:00, se agrega un día a la fecha
        if (hour >= 23) {
          fecha = fecha.add(const Duration(days: 1));
        } else if ((now.month == fecha.month && now.day != fecha.day)) {
          break;
        }

        // Creamos un nuevo objeto Temperatura con la fecha actualizada
        Temperatura temperatura = Temperatura(
          periodo: temperaturas.elementAt(i).periodo,
          value: temperaturas.elementAt(i).value,
          // fecha: fecha.toString(),
        );

        if (int.parse(cielo?.elementAt(0).periodo) !=
            int.parse(temperaturas.elementAt(0).periodo)) {
          cielo?.removeAt(0);
        }
        EstadoCielo estadoCielo = EstadoCielo(
            periodo: cielo?.elementAt(i).periodo,
            value: cielo?.elementAt(i).value,
            descripcion: cielo?.elementAt(i).descripcion

            // fecha: fecha.toString(),
            );

        allTemperaturas.add(temperatura);
        allEstadoCielo.add(estadoCielo);
      }
    }
  }

  return [allEstadoCielo, allTemperaturas];
}
