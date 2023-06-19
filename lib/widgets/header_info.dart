import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/weather_provider.dart';

class HeaderInfo extends StatefulWidget {
  const HeaderInfo({super.key});

  @override
  State<HeaderInfo> createState() => _HeaderInfoState();
}

class _HeaderInfoState extends State<HeaderInfo> {
  String city = '';
  String date = DateFormat("yMMMMd").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    getLocaton(weatherProvider.getLat(), weatherProvider.getLong());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.topLeft,
            child: Text(
              city,
              style: const TextStyle(fontSize: 35, color: Colors.white),
            )),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            alignment: Alignment.topLeft,
            child: Text(
              date,
              style: TextStyle(fontSize: 15, color: Colors.grey[100]),
            )),
      ],
    );
  }

  getLocaton(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];

    setState(() {
      city = place.locality!;
    });
  }
}
