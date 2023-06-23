import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:radarweather/entities/current_weather.dart';

class CurrentWeatherInfo extends StatelessWidget {
  final CurrentWeather currentWeather;
  const CurrentWeatherInfo({
    super.key,
    required this.currentWeather,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Lottie.asset('assets/1/${currentWeather.icon}.json',
            width: 128, height: 128),
        const SizedBox(height: 10),
        Text('${currentWeather.tmp.toInt()}º',
            style: const TextStyle(fontSize: 80, color: Colors.white)),
        Text(
          currentWeather.condition,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Max: ${currentWeather.tmpMax.toInt()}º',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Min: ${currentWeather.tmpMin.toInt()}º',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        )
      ],
    );
  }
}
