import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ForecastDayList extends StatelessWidget {
  final double? tempMax;
  final double? tempMin;
  final String? timeEpoch;
  final bool? esAemet;
  final double? totalprecipMm;
  final String? code;
  final double? maxWind;

  const ForecastDayList(
      {super.key,
      this.code,
      this.maxWind,
      this.tempMax,
      this.tempMin,
      this.timeEpoch,
      this.totalprecipMm,
      this.esAemet});

  String getTime(final timeStamp) {
    String formattedTime;
    if (esAemet!) {
      DateTime dateTimeAemet = DateTime.parse(timeStamp);
      formattedTime = DateFormat('E').format(dateTimeAemet);
    } else {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      formattedTime = DateFormat('E').format(dateTime);
    }
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 20,
          width: 33,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            getTime(timeEpoch),
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/aemetIcons/aemet/$code.json',
                width: 32, height: 32),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$totalprecipMm %',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${tempMax!.toInt()}º",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "${tempMin!.toInt()}º",
              style: const TextStyle(color: Colors.white54),
            ),
          ],
        )
      ],
    );
  }
}
