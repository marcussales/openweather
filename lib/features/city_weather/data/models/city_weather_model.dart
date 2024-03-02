// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weather_poc_flutter/features/city_weather/domain/entities/city_weather.dart';


class CityWeatherModel {
  final int? averageTemperature;
  final int? temperatureMin;
  final int? temperatureMax;
  final DateTime? dt;
  final String? weatherDescription;
  final String? iconCode;
  CityWeatherModel({
    this.averageTemperature,
    this.temperatureMin,
    this.temperatureMax,
    this.dt,
    this.weatherDescription,
    this.iconCode,
  });

  CityWeatherModel copyWith({
    int? averageTemperature,
    int? temperatureMin,
    int? temperatureMax,
    DateTime? dt,
    String? weatherDescription,
    String? iconCode,
  }) {
    return CityWeatherModel(
      averageTemperature: averageTemperature ?? this.averageTemperature,
      temperatureMin: temperatureMin ?? this.temperatureMin,
      temperatureMax: temperatureMax ?? this.temperatureMax,
      dt: dt ?? this.dt,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      iconCode: iconCode ?? this.iconCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'averageTemperature': averageTemperature,
      'temperatureMin': temperatureMin,
      'temperatureMax': temperatureMax,
      'dt': dt,
      'weatherDescription': weatherDescription,
      'iconCode': iconCode,
    };
  }

  factory CityWeatherModel.fromMap(Map<String, dynamic> map) {
    return CityWeatherModel(
      averageTemperature: (map['averageTemperature'] ?? 0.0) as int,
      temperatureMin: (map['temperatureMin'] ?? 0.0) as int,
      temperatureMax: (map['temperatureMax'] ?? 0.0) as int,
      dt: (map['dt'] ?? 0) as DateTime,
      weatherDescription: (map['weatherDescription'] ?? '') as String,
      iconCode: (map['iconCode'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityWeatherModel.fromJson(String source) =>
      CityWeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CityWeatherModel(averageTemperature: $averageTemperature, temperatureMin: $temperatureMin, temperatureMax: $temperatureMax, dt: $dt, weatherDescription: $weatherDescription, iconCode: $iconCode)';
  }

  @override
  bool operator ==(covariant CityWeatherModel other) {
    if (identical(this, other)) return true;

    return other.averageTemperature == averageTemperature &&
        other.temperatureMin == temperatureMin &&
        other.temperatureMax == temperatureMax &&
        other.dt == dt &&
        other.weatherDescription == weatherDescription &&
        other.iconCode == iconCode;
  }

  @override
  int get hashCode {
    return averageTemperature.hashCode ^
        temperatureMin.hashCode ^
        temperatureMax.hashCode ^
        dt.hashCode ^
        weatherDescription.hashCode ^
        iconCode.hashCode;
  }
}

extension CityWeatherModelExtension on CityWeatherModel {
  CityWeather toEntity() {
    return CityWeather(
      averageTemperature: averageTemperature,
      temperatureMin: temperatureMin,
      temperatureMax: temperatureMax,
      dt: dt,
      weatherDescription: weatherDescription,
      iconCode: iconCode,
    );
  }
}

extension CityWeatherModelList on List<CityWeatherModel> {
  List<CityWeather> toEntityList() => map((model) => model.toEntity()).toList();
}
