part of 'city_weather_bloc.dart';

enum CityWeatherDetailStateStatus { idle, loading }

class CityWeatherDetailState {
  final CityWeatherDetailStateStatus status;
  final List<CityWeather>? weatherForecast;

  const CityWeatherDetailState({this.status = CityWeatherDetailStateStatus.loading, this.weatherForecast});

  List<Object?> get props => [status, weatherForecast];

  CityWeatherDetailState copyWith({CityWeatherDetailStateStatus? status, List<CityWeather>? weatherForecast}) {
    return CityWeatherDetailState(
      status: status ?? this.status,
      weatherForecast: weatherForecast,
    );
  }
}
