import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../model/weatherV2/weather_api/weather_hourly.dart';

class HourlyList extends StatefulWidget {
  final Iterable<Iterable<Hourly>> hourEntities;

  const HourlyList({Key? key, required this.hourEntities}) : super(key: key);

  @override
  State<HourlyList> createState() => _HourlyListState();
}

class _HourlyListState extends State<HourlyList> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<Hourly> allHours = [];
    int currentIndex = 0;
    int showBorder = 0;
    //guardamos las siguentes horas, x3 dias
    for (Iterable<Hourly> dayHours in widget.hourEntities) {
      allHours.addAll(dayHours);
    }

    // Encontrar el índice de la hora actual más cercana
    for (int i = 0; i < allHours.length; i++) {
      DateTime hourlyTime =
          DateTime.fromMillisecondsSinceEpoch(allHours[i].timeEpoch! * 1000);
      if (hourlyTime.isAfter(now)) {
        currentIndex = i;
        break;
      }
    }

    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 25,
        itemBuilder: (context, index) {
          int hourIndex = currentIndex + index;

          if (hourIndex < allHours.length) {
            Hourly hourly = allHours[hourIndex];
            return Container(
              width: 90,
              margin: const EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  border: showBorder == index
                      ? Border.all(color: Colors.blue)
                      : Border.all(color: Colors.transparent)),
              child: HourlyDetails(
                index: index,
                temp: hourly.tempC as double,
                timeStamp: hourly.timeEpoch as int,
                weatherIcon: hourly.condition!.code as int,
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
  double temp;
  int index;

  int timeStamp;
  int weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.index,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon})
      : super(key: key);
  String getTime(final timeStamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

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
          child: Lottie.asset('assets/1/${weatherIcon}.json',
              width: 52, height: 52),
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
