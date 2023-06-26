import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'package:radarweather/provider/db_provider.dart';

class GetDailyWeatherAemet {
  String? city;

  getLocation(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    // print(place);
    city = place.locality!;
    return city;
  }

  getIdPoblacion(String city) async {
    final db = await DbProvider.db.initDB();
    final resultado = await DbProvider.db.buscarCiudad(db, city);
    return resultado;
  }

  getDailyWeatherAemet(lat, lon) async {
    var city = await getLocation(lat, lon);
    var cityId = await getIdPoblacion(city)!;
    cityId = cityId.first.values.first;

    cityId = cityId.toString().split('id');

    String apiDailyAemet =
        'https://opendata.aemet.es/opendata/api/prediccion/especifica/municipio/diaria/${cityId[1]}?api_key=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmZXJyYW5lY2hhdmVzQGdtYWlsLmNvbSIsImp0aSI6ImU3MzdhNGNlLWQ5NzUtNGUzZi04MzAyLWZhZTcxNjBiODgzNSIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNjg3Mzc3MjIzLCJ1c2VySWQiOiJlNzM3YTRjZS1kOTc1LTRlM2YtODMwMi1mYWU3MTYwYjg4MzUiLCJyb2xlIjoiIn0.98Cj_MSHJPQHYuQDzlPzVjtvzYYjePzX1q5dsrlVX1Y';
    final response = await http.get(Uri.parse(apiDailyAemet));
    var jasonString = jsonDecode(response.body);
    var data = jasonString['datos'];

    final responseWeather = await http.get(Uri.parse(data));
    var jsonWeather = jsonDecode(responseWeather.body);
    var datas = jsonWeather;

    // aemetIdData = AemetIdData(
    //   AemetIdPoblaciones.fromJson(jasonString),
    // );

    // return aemetIdData!;
  }
}
