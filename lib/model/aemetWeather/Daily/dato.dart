class Dato {
  int? value;
  int? hora;

  Dato({this.value, this.hora});

  factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        value: json['value'] as int?,
        hora: json['hora'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'hora': hora,
      };
}
