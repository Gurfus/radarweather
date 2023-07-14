import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:radarweather/helpers/hourly/get_sort_hours.dart';
import 'package:radarweather/model/aemetWeather/hourly/estado_cielo.dart';
import 'package:radarweather/model/aemetWeather/hourly/temperatura.dart';
import 'package:radarweather/model/aemetWeather/hourly/weather_hourly_aemet.dart';

import '../../model/weatherV2/weather_api/weather_hourly.dart';

class HourlyList extends StatefulWidget {
  final WeatherHourlyAemet? weatherHourlyAemet;
  const HourlyList({Key? key, this.weatherHourlyAemet}) : super(key: key);

  @override
  State<HourlyList> createState() => _HourlyListState();
}

class _HourlyListState extends State<HourlyList> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    now.hour;
    List<Hourly> allHours = [];
    //ordena las horas segun la hora actual
    var sortedHours = getSortHours(widget.weatherHourlyAemet!);

    List<Temperatura> allHoras = sortedHours[1];
    List<EstadoCielo> allEstadoCielo = sortedHours[0];
    int currentIndex = 0;
    int showBorder = 0;

    //guardamos las siguentes horas, x3 dias
    // for (Iterable<Hourly> dayHours in widget.hourEntities) {
    //   allHours.addAll(dayHours);
    // }

    // Encontrar el índice de la hora actual más cercana
    // for (int i = 0; i < allHours.length; i++) {
    //   DateTime hourlyTime =
    //       DateTime.fromMillisecondsSinceEpoch(allHours[i].timeEpoch! * 1000);
    //   if (hourlyTime.isAfter(now)) {
    //     currentIndex = i;
    //     break;
    //   }
    // }

    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 13,
        itemBuilder: (context, index) {
          int hourIndex = currentIndex + index;

          if (hourIndex < allHoras.length) {
            // Hourly hourly = allHours[hourIndex];
            return SingleChildScrollView(
              child: Container(
                width: 90,
                margin: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    border: showBorder == index
                        ? Border.all(color: Colors.blue)
                        : Border.all(color: Colors.transparent)),
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

// hourly details class
class HourlyDetails extends StatelessWidget {
  int temp;
  int index;
  bool esAemet;
  dynamic timeStamp;
  dynamic weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.index,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon,
      required this.esAemet})
      : super(key: key);
  String getTime(final timeStamp) {
    String formattedTime;
    if (esAemet) {
      formattedTime = '$timeStamp:00';
    } else {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      formattedTime = DateFormat('HH:mm').format(dateTime);
    }
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Lottie.asset('assets/aemetIcons/aemet/$weatherIcon.json',
              width: 48, height: 48),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°",
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
