class VientoAndRachaMax {
  final List<String>? direccion;
  final List<String>? velocidad;
  final String periodo;
  final String? value;

  VientoAndRachaMax({
    this.direccion,
    this.velocidad,
    required this.periodo,
    this.value,
  });

  factory VientoAndRachaMax.fromJson(Map<String, dynamic> json) =>
      VientoAndRachaMax(
        direccion: json["direccion"] == null
            ? []
            : List<String>.from(json["direccion"]!.map((x) => x)),
        velocidad: json["velocidad"] == null
            ? []
            : List<String>.from(json["velocidad"]!.map((x) => x)),
        periodo: json["periodo"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "direccion": direccion == null
            ? []
            : List<dynamic>.from(direccion!.map((x) => x)),
        "velocidad": velocidad == null
            ? []
            : List<dynamic>.from(velocidad!.map((x) => x)),
        "periodo": periodo,
        "value": value,
      };
}
