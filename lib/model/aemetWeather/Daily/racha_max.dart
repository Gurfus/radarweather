class RachaMax {
  final String? value;
  final String? periodo;

  RachaMax({
    this.value,
    this.periodo,
  });

  factory RachaMax.fromJson(Map<String, dynamic> json) => RachaMax(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
