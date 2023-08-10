import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/entities/current_weather.dart';
import 'package:radarweather/model/aemetWeather/Current/current_aemet/current_aemet.dart';
import 'package:radarweather/model/aemetWeather/Daily/weather_daily_aemet.dart';

import 'package:radarweather/model/weather/weather_current/weather_current.dart';
import 'package:radarweather/model/weatherV2/weather_api/weather_hourly.dart';

import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/widgets/current/card_info_today.dart';
import 'package:radarweather/widgets/current/current_weather_info.dart';

import 'package:radarweather/widgets/header_info.dart';
import 'package:radarweather/widgets/nextDays/next_days_card.dart';

import '../../model/aemetWeather/hourly/weather_hourly_aemet.dart';
import '../../model/weatherV2/weather_api/weather_forecast_days.dart';
import '../../widgets/hourly/hourly_card.dart';

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> with WidgetsBindingObserver {
  WeatherProvider? weatherProvider;
  CurrentWeather? currentWeather;
  CurrentAemet? currentAemet;
  WeatherHourlyAemet? weatherHourlyAemet;
  WeatherDailyAemet? weatherDailyAemet;
  Iterable<Iterable<Hourly>>? hourly;
  WeatherCurrent? weatherCurrent;
  Iterable<ForecastDays>? forecastDays;
  String? cityName;

  @override
  void initState() {
    // La diferencia clave entre read y watch es que read proporciona una
    //instancia actual del proveedor sin suscribirse a las actualizaciones,
    //mientras que watch se suscribe a las actualizaciones del proveedor y
    //reconstruye el widget cuando ocurren cambios en el mismo. En este caso, a
    //l utilizar read en initState(), nos aseguramos de que la ubicación se obtenga solo una vez y no se vuelva a llamar automáticamente cuando haya cambios en el proveedor.

    weatherProvider = context.read<WeatherProvider>();
    weatherProvider!.getLocation();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  refreshData() {
    weatherProvider?.getLocation();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    weatherProvider = context.watch<WeatherProvider>();

    if (!weatherProvider!.getIsloading()) {
      currentAemet = weatherProvider?.getCurrenAemet();
      weatherHourlyAemet = weatherProvider?.getHourlyAemet();
      weatherDailyAemet = weatherProvider?.getDalyAemet();
      cityName = weatherProvider?.getCityName();
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
            end: Alignment.topRight,
          ),
        ),
        child: weatherProvider!.getIsloading()
            ? Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.yellow,
                  size: 40,
                ),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  HeaderInfo(
                    cityName: cityName,
                    currentAemet: currentAemet,
                  ),
                  CurrentWeatherInfo(
                      currentAemet: currentAemet,
                      weatherDailyAemet: weatherDailyAemet,
                      weatherHourlyAemet: weatherHourlyAemet),
                  const SizedBox(height: 10),
                  CardInfoToday(
                      currentAemet: currentAemet,
                      weatherHourlyAemet: weatherHourlyAemet,
                      weatherDailyAemet: weatherDailyAemet),
                  const SizedBox(
                    height: 30,
                  ),
                  HourlyCard(
                    weatherHourlyAemet: weatherHourlyAemet,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  NextDaysCard(
                    weatherDailyAemet: weatherDailyAemet,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
      ),
    );
  }
}
