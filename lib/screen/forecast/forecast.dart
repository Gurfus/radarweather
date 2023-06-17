import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/widgets/current_weather_info.dart';
import 'package:radarweather/widgets/header_info.dart';

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  WeatherProvider? weatherProvider;
  @override
  void initState() {
    // La diferencia clave entre read y watch es que read proporciona una instancia actual del proveedor sin suscribirse a las actualizaciones, mientras que watch se suscribe a las actualizaciones del proveedor y reconstruye el widget cuando ocurren cambios en el mismo. En este caso, al utilizar read en initState(), nos aseguramos de que la ubicación se obtenga solo una vez y no se vuelva a llamar automáticamente cuando haya cambios en el proveedor.

    weatherProvider = context.read<WeatherProvider>();
    weatherProvider!.getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weatherProvider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ForeCast'),
      ),
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
                    CurrentWeatherInfo(
                        currentWeather:
                            weatherProvider!.getCurrentDataWeather())
                  ],
                )),
    );
  }
}
