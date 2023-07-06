class ProbTormenta {
  String? value;
  String? periodo;

  ProbTormenta({
    this.value,
    this.periodo,
  });

  factory ProbTormenta.fromJson(Map<String, dynamic> json) => ProbTormenta(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
