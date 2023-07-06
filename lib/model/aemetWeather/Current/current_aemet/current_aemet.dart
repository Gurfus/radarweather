class CurrentAemet {
  String? idema;
  double? lon;
  String? fint;
  double? prec;
  double? alt;
  double? lat;
  String? ubi;
  double? hr;
  double? tamin;
  double? ta;
  double? tamax;
  double? tpr;
  double? rviento;

  CurrentAemet({
    this.idema,
    this.lon,
    this.fint,
    this.prec,
    this.alt,
    this.lat,
    this.ubi,
    this.hr,
    this.tamin,
    this.ta,
    this.tamax,
    this.tpr,
    this.rviento,
  });

  factory CurrentAemet.fromJson(Map<String, dynamic> json) => CurrentAemet(
        idema: json['idema'] as String?,
        lon: (json['lon'] as num?)?.toDouble(),
        fint: json['fint'] as String?,
        prec: json['prec'] as double?,
        alt: json['alt'] as double?,
        lat: (json['lat'] as num?)?.toDouble(),
        ubi: json['ubi'] as String?,
        hr: json['hr'] as double?,
        tamin: (json['tamin'] as num?)?.toDouble(),
        ta: (json['ta'] as num?)?.toDouble(),
        tamax: (json['tamax'] as num?)?.toDouble(),
        tpr: (json['tpr'] as num?)?.toDouble(),
        rviento: json['rviento'] as double?,
      );

  Map<String, dynamic> toJson() => {
        'idema': idema,
        'lon': lon,
        'fint': fint,
        'prec': prec,
        'alt': alt,
        'lat': lat,
        'ubi': ubi,
        'hr': hr,
        'tamin': tamin,
        'ta': ta,
        'tamax': tamax,
        'tpr': tpr,
        'rviento': rviento,
      };

  CurrentAemet getCurrentAemetEntity() => CurrentAemet(
      ta: ta,
      tamax: tamax,
      tamin: tamin,
      hr: hr,
      prec: prec,
      fint: fint,
      idema: idema,
      rviento: rviento);
}
