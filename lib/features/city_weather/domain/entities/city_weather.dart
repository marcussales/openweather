class CityWeather {
  final int? averageTemperature;
  final int? temperatureMin;
  final int? temperatureMax;
  final DateTime? dt;
  final String? weatherDescription;
  final String? iconCode;

  CityWeather({
    required this.averageTemperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.dt,
    required this.weatherDescription,
    required this.iconCode,
  });
}
