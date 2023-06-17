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
    return Row(
      children: [
        Lottie.asset('assets/1003.json', width: 64, height: 64),
        Text('${currentWeather.tmp}'),
      ],
    );
  }
}
