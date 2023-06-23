import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/entities/current_weather.dart';
import 'package:radarweather/model/aemet_id_poblaciones/aemet_id_data.dart';
import 'package:radarweather/model/aemet_id_poblaciones/aemet_id_poblaciones.dart';
import 'package:radarweather/model/weather/weather_current/weather_current.dart';
import 'package:radarweather/model/weatherV2/weather_api/weather_hourly.dart';
import 'package:radarweather/provider/db_provider.dart';
import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/widgets/current/card_info_today.dart';
import 'package:radarweather/widgets/current/current_weather_info.dart';

import 'package:radarweather/widgets/header_info.dart';
import 'package:radarweather/widgets/nextDays/next_days_card.dart';

import '../../model/weatherV2/weather_api/weather_forecast_days.dart';
import '../../widgets/hourly/hourly_card.dart';

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  WeatherProvider? weatherProvider;
  CurrentWeather? currentWeather;
  Iterable<Iterable<Hourly>>? hourly;
  WeatherCurrent? weatherCurrent;
  Iterable<ForecastDays>? forecastDays;
  AemetIdPoblaciones? aemetIdPoblaciones;
  @override
  void initState() {
    // La diferencia clave entre read y watch es que read proporciona una
    //instancia actual del proveedor sin suscribirse a las actualizaciones,
    //mientras que watch se suscribe a las actualizaciones del proveedor y
    //reconstruye el widget cuando ocurren cambios en el mismo. En este caso, a
    //l utilizar read en initState(), nos aseguramos de que la ubicación se obtenga solo una vez y no se vuelva a llamar automáticamente cuando haya cambios en el proveedor.

    weatherProvider = context.read<WeatherProvider>();
    weatherProvider!.getLocation();
    weatherProvider!.getDataPoblaciones();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weatherProvider = context.watch<WeatherProvider>();
    if (!weatherProvider!.getIsloading()) {
      currentWeather = weatherProvider!.getCurrentDataWeather();
      hourly = weatherProvider!.getHourlyDataWeather();
      forecastDays = weatherProvider!.getForecastDays();
      DbProvider.db.database;

      //aemetIdPoblaciones = weatherProvider!.getPoblaciones();
      //print(aemetIdPoblaciones);
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 1, 26, 64),
              Color.fromARGB(255, 24, 143, 248)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
            child: weatherProvider!.getIsloading()
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const HeaderInfo(),
                      CurrentWeatherInfo(currentWeather: currentWeather!),
                      const SizedBox(height: 10),
                      CardInfoToday(currentWeather: currentWeather!),
                      const SizedBox(
                        height: 30,
                      ),
                      HourlyCard(
                        hourEntities: hourly,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      NextDaysCard(
                        forecastDays: forecastDays!,
                      )
                    ],
                  )),
      ),
    );
  }
}
