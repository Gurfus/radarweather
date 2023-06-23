import 'package:radarweather/model/aemet_id_poblaciones/aemet_id_poblaciones.dart';

class AemetIdData {
  AemetIdPoblaciones? aemetIdPoblaciones;

  AemetIdData([this.aemetIdPoblaciones]);

  AemetIdPoblaciones getIdData() => aemetIdPoblaciones!;
}
