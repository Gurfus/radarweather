class Wind {
  double? speed;
  int? deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: (json['speed'] as num?)?.toDouble(),
        deg: json['deg'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
      };
}
