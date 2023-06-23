class CurrentWeather {
  final double tmp;
  final double feels;
  final double tmpMin;
  final double tmpMax;
  final int humidity;
  final double pressure;
  final double wSpeed;
  final int icon;
  final String condition;
  final double precipMm;
  final String lastUpdate;

  CurrentWeather(
      this.lastUpdate,
      this.tmp,
      this.feels,
      this.tmpMin,
      this.tmpMax,
      this.humidity,
      this.pressure,
      this.wSpeed,
      this.icon,
      this.condition,
      this.precipMm);
}
