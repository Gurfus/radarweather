import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ForecastDayList extends StatelessWidget {
  double? tempMax;
  double? tempMin;
  int? timeEpoch;
  double? totalprecipMm;
  int? code;
  double? maxWind;

  ForecastDayList(
      {super.key,
      this.code,
      this.maxWind,
      this.tempMax,
      this.tempMin,
      this.timeEpoch,
      this.totalprecipMm});

  String getTime(final timeStamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String formattedTime = DateFormat('EEEE').format(dateTime);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            getTime(timeEpoch),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Container(
            child:
                Lottie.asset('assets/1/${code}.json', width: 32, height: 32)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$totalprecipMm mm',
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
