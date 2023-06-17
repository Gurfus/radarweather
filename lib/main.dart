import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/screen/forecast/forecast.dart';
//import 'package:radarweather/screen/mapscreen/radar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application`
  // `
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => WeatherProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Forecast(),
      ),
    );
  }
}
