import 'package:flutter/material.dart';

import '../../model/aemetWeather/hourly/weather_hourly_aemet.dart';

import 'hourly_list.dart';

class HourlyCard extends StatelessWidget {
  final WeatherHourlyAemet? weatherHourlyAemet;
  const HourlyCard({super.key, this.weatherHourlyAemet});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 6,
      color: Colors.black38,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            alignment: Alignment.topCenter,
            child: const Text("Próximas horas",
                style: TextStyle(fontSize: 17, color: Colors.white)),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: HourlyList(
                weatherHourlyAemet: weatherHourlyAemet,
              )),
        ],
      ),
    );
  }
}
