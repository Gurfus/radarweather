import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/provider/search_provider.dart';
import 'package:radarweather/provider/weather_provider.dart';

import 'package:radarweather/screen/home/home_page.dart';

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
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              background: const Color.fromARGB(219, 70, 54, 255)),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
