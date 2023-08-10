import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

// hourly details class
class HourlyDetails extends StatelessWidget {
  final int temp;
  final int index;
  final bool esAemet;
  final dynamic timeStamp;
  final dynamic weatherIcon;

  const HourlyDetails(
      {Key? key,
      required this.index,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon,
      required this.esAemet})
      : super(key: key);
  String getTime(final timeStamp) {
    String formattedTime;
    if (esAemet) {
      formattedTime = '$timeStamp:00';
    } else {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      formattedTime = DateFormat('HH:mm').format(dateTime);
    }
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Lottie.asset('assets/aemetIcons/aemet/$weatherIcon.json',
              width: 48, height: 48),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°",
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
