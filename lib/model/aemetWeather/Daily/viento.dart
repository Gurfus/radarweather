class Viento {
  String? direccion;
  int? velocidad;
  String? periodo;

  Viento({this.direccion, this.velocidad, this.periodo});

  factory Viento.fromJson(Map<String, dynamic> json) => Viento(
        direccion: json['direccion'] as String?,
        velocidad: json['velocidad'] as int?,
        periodo: json['periodo'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'direccion': direccion,
        'velocidad': velocidad,
        'periodo': periodo,
      };
}
