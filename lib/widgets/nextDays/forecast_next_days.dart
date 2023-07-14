import 'package:flutter/material.dart';

import 'package:radarweather/model/weatherV2/weather_api/weather_forecast_days.dart';

import '../../model/aemetWeather/Daily/dia.dart';
import '../../model/aemetWeather/Daily/weather_daily_aemet.dart';
import 'next_days_list.dart';

class ForecastNext extends StatelessWidget {
  final WeatherDailyAemet? weatherDailyAemet;
  const ForecastNext({super.key, this.weatherDailyAemet});

  @override
  Widget build(BuildContext context) {
    List<Dia>? dias =
        weatherDailyAemet?.prediccion?.dia?.map((e) => e).toList();
    dias?.removeAt(0);
    // print(dias?.first.fecha);

    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: dias?.length,
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
                esAemet: true,
                timeEpoch: dias?.elementAt(index).fecha,
                tempMax: dias?.elementAt(index).temperatura?.maxima?.toDouble(),
                tempMin: dias?.elementAt(index).temperatura?.minima?.toDouble(),
                totalprecipMm: dias
                    ?.elementAt(index)
                    .probPrecipitacion
                    ?.first
                    .value
                    ?.toDouble(),
                code: dias!.elementAt(index).estadoCielo!.first.value,
              ));
          // child: ForecastDayList(
          //   timeEpoch: forecastDays.elementAt(index).dateEpoch,
          //   tempMax: forecastDays.elementAt(index).maxtempC,
          //   tempMin: forecastDays.elementAt(index).mintempC,
          //   maxWind: forecastDays.elementAt(index).maxwindKph,
          //   totalprecipMm: forecastDays.elementAt(index).totalprecipMm,
          //   code: forecastDays.elementAt(index).condition!.code,
          // ));
        },
      ),
    );
  }
}
