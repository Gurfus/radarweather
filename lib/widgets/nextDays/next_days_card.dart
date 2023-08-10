import 'package:flutter/material.dart';

import 'package:radarweather/widgets/nextDays/forecast_next_days.dart';

import '../../model/aemetWeather/Daily/weather_daily_aemet.dart';

class NextDaysCard extends StatelessWidget {
  final WeatherDailyAemet? weatherDailyAemet;
  const NextDaysCard({super.key, this.weatherDailyAemet});

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
            child: const Text("Próximos días",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          Container(
              height: 350,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ForecastNext(
                weatherDailyAemet: weatherDailyAemet,
              )),
        ],
      ),
    );
  }
}
