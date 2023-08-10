import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:radarweather/model/aemetWeather/Daily/weather_daily_aemet.dart';
import 'package:radarweather/model/aemetWeather/hourly/estado_cielo.dart';
import 'package:radarweather/model/aemetWeather/hourly/weather_hourly_aemet.dart';

import '../../model/aemetWeather/Current/current_aemet/current_aemet.dart';

class CurrentWeatherInfo extends StatelessWidget {
  final CurrentAemet? currentAemet;
  final WeatherDailyAemet? weatherDailyAemet;
  final WeatherHourlyAemet? weatherHourlyAemet;
  const CurrentWeatherInfo({
    super.key,
    this.currentAemet,
    this.weatherDailyAemet,
    this.weatherHourlyAemet,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    now.hour;

    List<EstadoCielo> allHoras = [];

    for (var dia in weatherHourlyAemet?.prediccion?.dia ?? []) {
      List<dynamic>? horas = dia.estadoCielo?.map((e) => e).toList();

      for (int i = 0; i < horas!.length; i++) {
        int hour = int.parse(horas.elementAt(i).periodo!);
        DateTime fecha = DateTime.parse(dia.fecha!);

        // Si es el primer día y la hora es menor o igual a la hora actual,
        // o si es un día posterior, se agregan las horas a la lista
        if ((dia == weatherHourlyAemet?.prediccion?.dia?.first &&
                hour == now.hour) ||
            (dia != weatherHourlyAemet?.prediccion?.dia?.first)) {
          // Si es a partir de las 23:00, se agrega un día a la fecha
          if (hour >= 23) {
            fecha = fecha.add(const Duration(days: 1));
          }

          // Creamos un nuevo objeto Temperatura con la fecha actualizada
          EstadoCielo estadoCielo = EstadoCielo(
              periodo: horas.elementAt(i).periodo,
              value: horas.elementAt(i).value,
              descripcion: horas.elementAt(i).descripcion);

          allHoras.add(estadoCielo);
        }
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/aemetIcons/aemet/${allHoras.first.value}.json',
            width: 128, height: 128),
        const SizedBox(height: 10),
        Text('${currentAemet?.ta?.round()}º',
            style: const TextStyle(fontSize: 80, color: Colors.white)),
        Text(
          allHoras.first.descripcion.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Max: ${weatherDailyAemet?.prediccion?.dia?.first.temperatura?.maxima}º',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Min: ${weatherDailyAemet?.prediccion?.dia?.first.temperatura?.minima}º',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        )
      ],
    );
  }
}
