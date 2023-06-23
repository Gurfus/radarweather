import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radarweather/model/aemet_id_poblaciones/aemet_id_data.dart';
import 'package:radarweather/model/aemet_id_poblaciones/aemet_id_poblaciones.dart';

class GetPoblaciones {
  AemetIdPoblaciones? aemetIdPoblaciones;
  AemetIdData? aemetIdData;

  Future<AemetIdData> getIdPoblaciones() async {
    String aemetPoblacion =
        'https://opendata.aemet.es/opendata/api/maestro/municipios?api_key=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmZXJyYW5lY2hhdmVzQGdtYWlsLmNvbSIsImp0aSI6ImU3MzdhNGNlLWQ5NzUtNGUzZi04MzAyLWZhZTcxNjBiODgzNSIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNjg3Mzc3MjIzLCJ1c2VySWQiOiJlNzM3YTRjZS1kOTc1LTRlM2YtODMwMi1mYWU3MTYwYjg4MzUiLCJyb2xlIjoiIn0.98Cj_MSHJPQHYuQDzlPzVjtvzYYjePzX1q5dsrlVX1Y';
    final response = await http.get(Uri.parse(aemetPoblacion));
    var jasonString = jsonDecode(response.body);

    aemetIdData = AemetIdData(
      AemetIdPoblaciones.fromJson(jasonString),
    );

    return aemetIdData!;
  }
}
