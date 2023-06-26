import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:radarweather/provider/db_provider.dart';

class GetCurrentWeatherAemet {
  String? estacion;

  getEstacion(lat, long) async {
    final resultado = await DbProvider.db.buscarEstacionCercana(lat, long);
    return resultado;
  }

  getCurrentAemet(lat, lon) async {
    var estacion = await getEstacion(lat, lon);

    estacion = estacion.values.first;

    String apiAemetCurrent =
        'https://opendata.aemet.es/opendata/api/observacion/convencional/datos/estacion/$estacion?api_key=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmZXJyYW5lY2hhdmVzQGdtYWlsLmNvbSIsImp0aSI6ImU3MzdhNGNlLWQ5NzUtNGUzZi04MzAyLWZhZTcxNjBiODgzNSIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNjg3Mzc3MjIzLCJ1c2VySWQiOiJlNzM3YTRjZS1kOTc1LTRlM2YtODMwMi1mYWU3MTYwYjg4MzUiLCJyb2xlIjoiIn0.98Cj_MSHJPQHYuQDzlPzVjtvzYYjePzX1q5dsrlVX1Y';
    final response = await http.get(Uri.parse(apiAemetCurrent));
    var jsonAemet = jsonDecode(response.body);
    var data = jsonAemet['datos'];

    final responseWeather = await http.get(Uri.parse(data));
    var jsonWeather = jsonDecode(responseWeather.body);
    var datas = jsonWeather;
    print(datas);

    // aemetIdData = AemetIdData(
    //   AemetIdPoblaciones.fromJson(jasonString),
    // );

    // return aemetIdData!;
  }
}
