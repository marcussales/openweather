part of 'city_weather_bloc.dart';

sealed class CityWeatherDetailEvent {}

class GetCityWeatherDetailEvent extends CityWeatherDetailEvent {
  final String? cityName;
  GetCityWeatherDetailEvent(this.cityName);
}
