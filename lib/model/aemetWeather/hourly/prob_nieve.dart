class ProbNieve {
  String? value;
  String? periodo;

  ProbNieve({
    this.value,
    this.periodo,
  });

  factory ProbNieve.fromJson(Map<String, dynamic> json) => ProbNieve(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
