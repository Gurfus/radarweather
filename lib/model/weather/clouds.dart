class Clouds {
  int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json['all'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'all': all,
      };
}
