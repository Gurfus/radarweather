import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:radarweather/model/aemetWeather/Current/current_aemet/current_aemet.dart';
import 'package:radarweather/model/aemetWeather/Daily/weather_daily_aemet.dart';
import 'package:radarweather/model/aemetWeather/hourly/weather_hourly_aemet.dart';

class CardInfoToday extends StatelessWidget {
  final CurrentAemet? currentAemet;
  final WeatherHourlyAemet? weatherHourlyAemet;

  final WeatherDailyAemet? weatherDailyAemet;
  const CardInfoToday({
    super.key,
    this.currentAemet,
    this.weatherHourlyAemet,
    this.weatherDailyAemet,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 6,
      color: Colors.black45,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(
                '${currentAemet?.hr}%',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  Lottie.asset('assets/aemetIcons/aemet/sunrise.json',
                      width: 28, height: 28),
                  Text(
                    '${weatherHourlyAemet?.prediccion?.dia?.first.orto} ',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: 1,
              ),
              Row(
                children: [
                  Lottie.asset(
                    'assets/aemetIcons/aemet/sunset.json',
                    width: 28,
                    height: 28,
                  ),
                  Text(
                    '${weatherHourlyAemet?.prediccion?.dia?.first.ocaso}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${currentAemet?.prec} mm',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 5)
            ],
          )),
    );
  }
}
