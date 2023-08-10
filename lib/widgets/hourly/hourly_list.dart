import 'package:flutter/material.dart';

import 'package:radarweather/helpers/hourly/get_sort_hours.dart';
import 'package:radarweather/model/aemetWeather/hourly/estado_cielo.dart';
import 'package:radarweather/model/aemetWeather/hourly/temperatura.dart';
import 'package:radarweather/model/aemetWeather/hourly/weather_hourly_aemet.dart';

import 'hourly_details.dart';

class HourlyList extends StatefulWidget {
  final WeatherHourlyAemet? weatherHourlyAemet;
  const HourlyList({Key? key, this.weatherHourlyAemet}) : super(key: key);

  @override
  State<HourlyList> createState() => _HourlyListState();
}

class _HourlyListState extends State<HourlyList> {
  @override
  Widget build(BuildContext context) {
    //ordena las horas segun la hora actual
    var sortedHours = getSortHours(widget.weatherHourlyAemet!);

    List<Temperatura> allHoras = sortedHours[1];
    List<EstadoCielo> allEstadoCielo = sortedHours[0];
    int currentIndex = 0;

    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 13,
        itemBuilder: (context, index) {
          int hourIndex = currentIndex + index;

          if (hourIndex < allHoras.length) {
            return SingleChildScrollView(
              child: Container(
                width: 90,
                margin: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                ),
                child: HourlyDetails(
                  esAemet: true,
                  index: index,
                  temp: int.parse(allHoras.elementAt(index).value!),
                  timeStamp: allHoras.elementAt(index).periodo!,
                  weatherIcon: allEstadoCielo.elementAt(index).value,
                ),
              ),
            );
          } else {
            return Container(); // Si no hay más horas para mostrar, retornar un contenedor vacío
          }
        },
      ),
    );
  }
}
