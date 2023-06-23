class AemetIdPoblaciones {
  String? latitud;
  String? idOld;
  String? url;
  String? latitudDec;
  String? altitud;
  String? capital;
  String? numHab;
  String? zonaComarcal;
  String? destacada;
  String? nombre;
  String? longitudDec;
  String? id;
  String? longitud;

  AemetIdPoblaciones({
    this.latitud,
    this.idOld,
    this.url,
    this.latitudDec,
    this.altitud,
    this.capital,
    this.numHab,
    this.zonaComarcal,
    this.destacada,
    this.nombre,
    this.longitudDec,
    this.id,
    this.longitud,
  });

  factory AemetIdPoblaciones.fromJson(Map<String, dynamic> json) {
    return AemetIdPoblaciones(
      latitud: json['latitud'] as String?,
      idOld: json['id_old'] as String?,
      url: json['url'] as String?,
      latitudDec: json['latitud_dec'] as String?,
      altitud: json['altitud'] as String?,
      capital: json['capital'] as String?,
      numHab: json['num_hab'] as String?,
      zonaComarcal: json['zona_comarcal'] as String?,
      destacada: json['destacada'] as String?,
      nombre: json['nombre'] as String?,
      longitudDec: json['longitud_dec'] as String?,
      id: json['id'] as String?,
      longitud: json['longitud'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'latitud': latitud,
        'id_old': idOld,
        'url': url,
        'latitud_dec': latitudDec,
        'altitud': altitud,
        'capital': capital,
        'num_hab': numHab,
        'zona_comarcal': zonaComarcal,
        'destacada': destacada,
        'nombre': nombre,
        'longitud_dec': longitudDec,
        'id': id,
        'longitud': longitud,
      };
}
