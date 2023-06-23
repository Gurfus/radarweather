import 'package:flutter/material.dart';
import 'package:radarweather/entities/current_weather.dart';

class CardInfoToday extends StatelessWidget {
  final CurrentWeather currentWeather;
  const CardInfoToday({
    super.key,
    required this.currentWeather,
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
              Text(
                '${currentWeather.humidity}%',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${currentWeather.wSpeed} Km/h',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${currentWeather.precipMm} mm',
                style: const TextStyle(color: Colors.white),
              )
            ],
          )),
    );
  }
}
