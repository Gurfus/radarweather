import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/model/aemetWeather/Current/current_aemet/current_aemet.dart';

import '../provider/weather_provider.dart';

class HeaderInfo extends StatefulWidget {
  final String? cityName;
  final CurrentAemet? currentAemet;
  const HeaderInfo({super.key, this.cityName, this.currentAemet});

  @override
  State<HeaderInfo> createState() => _HeaderInfoState();
}

class _HeaderInfoState extends State<HeaderInfo> {
  String? city = '';
  String date = DateFormat("yMMMMd").format(DateTime.now());
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    dynamic lastUpdate = widget.currentAemet?.fint;
    DateTime dateTimeAemet = DateTime.parse(lastUpdate!);
    lastUpdate = dateTimeAemet.add(const Duration(hours: 2));
    lastUpdate = DateFormat('k').format(lastUpdate);

    if (widget.cityName == null) {
      city = weatherProvider.getCityName();
    } else {
      city = widget.cityName;
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Text(
                          city!,
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.topRight,
              child: Spin(
                animate: animate,
                spins: 1,
                child: FloatingActionButton.small(
                  onPressed: () async {
                    setState(() {
                      animate = true;
                    });

                    await weatherProvider.getDataApi(
                        weatherProvider.getLat(), weatherProvider.getLong());
                    city = weatherProvider.getCityName();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        animate = false;
                      });
                    });
                    Fluttertoast.showToast(
                        msg: "Datos actualizados",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.green,
                        timeInSecForIosWeb: 1);
                  },
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: const Icon(
                    LineIcons.syncIcon,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Text(
                  date,
                  style: TextStyle(fontSize: 12, color: Colors.grey[100]),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Última act: $lastUpdate - ${widget.currentAemet!.idema}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            )),
      ],
    );
  }
}
