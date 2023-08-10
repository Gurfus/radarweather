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
import '../../provider/search_provider.dart';
import '../../widgets/hourly/hourly_card.dart';

class ForecastSearch extends StatefulWidget {
  const ForecastSearch({super.key});

  @override
  State<ForecastSearch> createState() => _ForecastSearchState();
}

class _ForecastSearchState extends State<ForecastSearch> {
  WeatherProvider? weatherProvider;
  CurrentWeather? currentWeather;
  CurrentAemet? currentAemet;
  WeatherHourlyAemet? weatherHourlyAemet;
  WeatherDailyAemet? weatherDailyAemet;
  Iterable<Iterable<Hourly>>? hourly;
  WeatherCurrent? weatherCurrent;
  Iterable<ForecastDays>? forecastDays;
  SearchProvider? searchProvider;
  String? cityName;
  @override
  void initState() {
    // La diferencia clave entre read y watch es que read proporciona una
    //instancia actual del proveedor sin suscribirse a las actualizaciones,
    //mientras que watch se suscribe a las actualizaciones del proveedor y
    //reconstruye el widget cuando ocurren cambios en el mismo. En este caso, a
    //l utilizar read en initState(), nos aseguramos de que la ubicación se obtenga solo una vez y no se vuelva a llamar automáticamente cuando haya cambios en el proveedor.

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchProvider = context.watch<SearchProvider>();
    if (!searchProvider!.getIsloading()) {
      currentAemet = searchProvider?.getCurrenAemet();
      weatherHourlyAemet = searchProvider?.getHourlyAemet();
      weatherDailyAemet = searchProvider?.getDalyAemet();
      cityName = searchProvider?.getCityName();
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
        child: searchProvider!.getIsloading()
            ? Center(
                child: Column(
                  children: [
                    LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.yellow,
                      size: 40,
                    ),
                    const Text(
                      'Cargando..',
                      style: TextStyle(fontSize: 20, color: Colors.yellow),
                    )
                  ],
                ),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 1,
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
