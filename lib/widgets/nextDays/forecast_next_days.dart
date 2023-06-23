import 'package:flutter/material.dart';

import 'package:radarweather/model/weatherV2/weather_api/weather_forecast_days.dart';

import 'next_days_list.dart';

class ForecastNext extends StatelessWidget {
  final Iterable<ForecastDays> forecastDays;
  const ForecastNext({super.key, required this.forecastDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: forecastDays.length,
        itemBuilder: (context, index) {
          return Container(
              // width: 30,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                border: Border.all(color: Colors.transparent),
              ),
              child: ForecastDayList(
                timeEpoch: forecastDays.elementAt(index).dateEpoch,
                tempMax: forecastDays.elementAt(index).maxtempC,
                tempMin: forecastDays.elementAt(index).mintempC,
                maxWind: forecastDays.elementAt(index).maxwindKph,
                totalprecipMm: forecastDays.elementAt(index).totalprecipMm,
                code: forecastDays.elementAt(index).condition!.code,
              ));
        },
      ),
    );
  }
}
