import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  bool animate = false;
  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    city = weatherProvider.getCityName();
    if (city != weatherProvider.cityName) {
      setState(() {
        city;
      });
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
                    child: Text(
                      city,
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    )),
              ],
            ),
            Container(
              alignment: Alignment.topRight,
              child: Spin(
                //duration: Duration(milliseconds: 2000),

                animate: animate,
                //infinite: animate,
                spins: 1,
                child: FloatingActionButton.small(
                  onPressed: () async {
                    setState(() {
                      animate = true;

                      // weatherProvider.setIsloadinng(true);
                    });

                    await weatherProvider.getDataApi(
                        weatherProvider.getLat(), weatherProvider.getLong());
                    city = weatherProvider.getCityName();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() async {
                        animate = false;
                        //weatherProvider.setIsloadinng(false);
                      });
                    });
                    Fluttertoast.showToast(
                        msg: "Datos actualizados",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.green,
                        timeInSecForIosWeb: 1);
                  },
                  backgroundColor: Colors.transparent,
                  child: const Icon(
                    Icons.refresh_rounded,
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
            child: Text(
              date,
              style: TextStyle(fontSize: 12, color: Colors.grey[100]),
            )),
      ],
    );
  }
}
