import 'package:flutter/material.dart';

import 'package:radarweather/widgets/nextDays/forecast_next_days.dart';

import '../../model/weatherV2/weather_api/weather_forecast_days.dart';

class NextDaysCard extends StatelessWidget {
  final Iterable<ForecastDays> forecastDays;
  const NextDaysCard({super.key, required this.forecastDays});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 6,
      color: Colors.black54,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            alignment: Alignment.topCenter,
            child: const Text("Next Days",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ForecastNext(
                forecastDays: forecastDays,
              )),
        ],
      ),
    );
  }
}
