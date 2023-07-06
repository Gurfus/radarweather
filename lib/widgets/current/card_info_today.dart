import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radarweather/entities/current_weather.dart';
import 'package:radarweather/model/aemetWeather/Current/current_aemet/current_aemet.dart';
import 'package:radarweather/model/aemetWeather/Daily/weather_daily_aemet.dart';
import 'package:radarweather/model/aemetWeather/hourly/weather_hourly_aemet.dart';

class CardInfoToday extends StatelessWidget {
  final CurrentWeather currentWeather;
  final CurrentAemet? currentAemet;
  final WeatherHourlyAemet? weatherHourlyAemet;

  final WeatherDailyAemet? weatherDailyAemet;
  const CardInfoToday({
    super.key,
    required this.currentWeather,
    this.currentAemet,
    this.weatherHourlyAemet,
    this.weatherDailyAemet,
  });

  @override
  Widget build(BuildContext context) {
    // print(weatherDailyAemet?.prediccion?.dia?.first.viento?.first.velocidad);

    dynamic lastUpdate = currentAemet?.fint;
    DateTime dateTimeAemet = DateTime.parse(lastUpdate!);
    lastUpdate = DateFormat('k').format(dateTimeAemet);
    var intUpdate = int.parse(lastUpdate);
    intUpdate += 2;
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
              SizedBox(width: 5),
              Text(
                '${currentAemet?.hr}%',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Última act: ${intUpdate} - ${currentAemet!.idema}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${currentAemet?.prec} mm',
                style: const TextStyle(color: Colors.white),
              ),
              SizedBox(width: 5)
            ],
          )),
    );
  }
}
