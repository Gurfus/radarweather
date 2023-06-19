import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/entities/current_weather.dart';
import 'package:radarweather/model/weather/weather_current/weather_current.dart';
import 'package:radarweather/model/weatherV2/weather_api/weather_hourly.dart';
import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/widgets/card_info_today.dart';
import 'package:radarweather/widgets/current_weather_info.dart';
import 'package:radarweather/widgets/forecast_card.dart';
import 'package:radarweather/widgets/header_info.dart';

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
  @override
  void initState() {
    // La diferencia clave entre read y watch es que read proporciona una
    //instancia actual del proveedor sin suscribirse a las actualizaciones,
    //mientras que watch se suscribe a las actualizaciones del proveedor y
    //reconstruye el widget cuando ocurren cambios en el mismo. En este caso, a
    //l utilizar read en initState(), nos aseguramos de que la ubicación se obtenga solo una vez y no se vuelva a llamar automáticamente cuando haya cambios en el proveedor.

    weatherProvider = context.read<WeatherProvider>();
    weatherProvider!.getLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weatherProvider = context.watch<WeatherProvider>();
    currentWeather = weatherProvider!.getCurrentDataWeather();
    hourly = weatherProvider!.getHourlyDataWeather();

    return Scaffold(
      body: SafeArea(
          child: weatherProvider!.getIsloading()
              ? const Center(
                  child: CircularProgressIndicator(),
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
                    SizedBox(
                      height: 30,
                    ),
                    ForecastCard(
                      hourEntities: hourly,
                    )
                  ],
                )),
    );
  }
}
