import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/weatherV2/weather_api/weather_hourly.dart';

import 'hourly_list.dart';

class HourlyCard extends StatelessWidget {
  final Iterable<Iterable<Hourly>>? hourEntities;
  const HourlyCard({super.key, this.hourEntities});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 6,
      color: Colors.black38,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            alignment: Alignment.topCenter,
            child: const Text("Next 24 hours",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: HourlyList(hourEntities: hourEntities!)),
        ],
      ),
    );
  }
}
